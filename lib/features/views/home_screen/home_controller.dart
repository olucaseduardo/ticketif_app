import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:ticket_ifma/features/repositories/user/user_api_repository_impl.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
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

  /// Realiza a leitura dos dados do aluno no banco de dados
  Future<void> loadData() async {
    try {
      userTickets!.clear();
      todayTickets!.clear();

      isLoading = true;

      await Links.i.loadLink();
      final userData = await UserApiRepositoryImpl().loadUser();
      final tickets =
          await TicketsApiRepositoryImpl().findAllTickets(userData.id);

      final sp = await SharedPreferences.getInstance();
      sp.setInt('idStudent', userData.id);

      user = userData;

      // verificando quais os tickets do aluno para o dia
      for (var index = 0; index < tickets.length; index++) {
        log(tickets.elementAt(index).toString());
        if (tickets.elementAt(index).useDayDate != '') {
          if (DateTime.parse(tickets.elementAt(index).useDayDate).day ==
                  DateTime.now().day &&
              DateTime.parse(tickets.elementAt(index).useDayDate).month ==
                  DateTime.now().month) {
            todayTickets?.add(tickets.elementAt(index));
            userTickets?.add(tickets.elementAt(index));
          } else {
            log(tickets.elementAt(index).toString());
            userTickets?.add(tickets.elementAt(index));
          }
        }
      }

      todayTickets!.sort((a, b) => a.idMeal.compareTo(b.idMeal));

      // verificando qual o ticket deve ser exibido na homescreen
      final hour = DateTime.now().hour;
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

      userTickets!.sort((a, b) => b.useDayDate.compareTo(a.useDayDate));
      loading();
    } catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  /// Realza a confimação do aluno de que irá almoçar
  Future<void> changeTicket(int idTicket, int status) async {
    int statusId = 1;
    final hour = DateTime.now().hour;

    if (status == 1) {
      // Cancela o ticket
      statusId = 6;
    } else if (status == 2 && (hour > 12 || (hour >= 7 && hour < 9))) {
      // Confirma presença
      statusId = 4;
    } else {
      AppMessage.i
          .showInfo('A confirmação só está disponível no período das 7h às 9h');
      return;
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
