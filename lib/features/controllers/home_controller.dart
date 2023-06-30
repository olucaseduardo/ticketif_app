import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/data/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/data/user/user_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  User? user;
  List<Ticket>? userTickets = [];
  List<Ticket>? todayTickets = [];
  bool isLoading = true;
  bool error = false;

  Ticket? todayTicket;

  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadData() async {
    try {
      userTickets!.clear();
      todayTickets!.clear();

      isLoading = true;

      final userData = await UserApiRepositoryImpl().loadUser();
      final tickets =
          await TicketsApiRepositoryImpl().findAllTickets(userData.id);

      final sp = await SharedPreferences.getInstance();
      sp.setInt('idStudent', userData.id);

      user = userData;

      for (var i = 0; i < tickets.length; i++) {
        if (tickets.elementAt(i).useDayDate != '') {
          if (DateTime.parse(tickets.elementAt(i).useDayDate).day ==
                  DateTime.now().day &&
              DateTime.parse(tickets.elementAt(i).useDayDate).month ==
                  DateTime.now().month) {
            todayTickets?.add(tickets.elementAt(i));
            userTickets?.add(tickets.elementAt(i));
          } else {
            userTickets?.add(tickets.elementAt(i));
          }
        }
      }

      todayTickets!.sort((a, b) => a.idMeal.compareTo(b.idMeal));

      if (todayTickets!.length == 1) {
        todayTicket = todayTickets!.first;
      }

      var hour = DateTime.now().hour;
      for (var ticket in todayTickets!) {
        if (hour >= 8 && hour <= 12) {
          if (ticket.idMeal == 2) {
            todayTicket = ticket;
          }
        } else if (hour >= 13 && hour <= 19) {
          if (ticket.idMeal == 3) {
            todayTicket = ticket;
          }
        }
      }
      log(todayTicket.toString());
      userTickets!.sort((a, b) => b.useDayDate.compareTo(a.useDayDate));
      loading();
    } catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  Future<void> changeTicket(int idTicket, int status) async {
    int statusId = 1;

    if (status == 1) {
      statusId = 6;
    } else if (status == 2) {
      statusId = 4;
    }

    try {
      await TicketsApiRepositoryImpl().changeStatusTicket(idTicket, statusId);
      isLoading = true;
      notifyListeners();
      await loadData();
    } on DioError catch (e, s) {
      log('Erro ao cancelar ticket', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao cancelar ticket');
    }
  }
}
