import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaeController extends ChangeNotifier {
  List<Ticket>? dailyTickets = [];
  List<Ticket>? permanentesTickets = [];
  Map<String, List<Ticket>> dailyClasses = {};
  Map<String, List<Ticket>> permanentClasses = {};
  bool isLoading = true;
  bool error = false;
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadDataTickets(String date) async {
    try {
      dailyTickets!.clear();
      permanentesTickets!.clear();
      dailyClasses.clear();
      permanentClasses.clear();
      isLoading = true;
      final tickets =
          await TicketsApiRepositoryImpl().findAllDailyTickets(date);

      dailyTickets =
          tickets.where((element) => element.isPermanent == 0).toList();
      permanentesTickets =
          tickets.where((element) => element.isPermanent == 1).toList();
      dailyTickets?.forEach(
        (element) => log(element.toString()),
      );

      String dailyClassName = '';
      String permanentClassName = '';

      dailyTickets?.forEach((element) {
        dailyClassName =
            element.student.substring(0, element.student.length - 4);
        if (dailyClasses.containsKey(dailyClassName)) {
          dailyClasses[dailyClassName]!.add(element);
        } else {
          dailyClasses[dailyClassName] = [element];
        }
        log(dailyClasses.toString());
      });

      permanentesTickets?.forEach((element) {
        permanentClassName =
            element.student.substring(0, element.student.length - 4);
        if (permanentClasses.containsKey(permanentClassName)) {
          permanentClasses[permanentClassName]!.add(element);
        } else {
          permanentClasses[permanentClassName] = [element];
        }
        // log(permanentClassName.toString());
      });

      loading();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  Future<void> changeTicketCAE(int idTicket, int status) async {
  
    try {
      await TicketsApiRepositoryImpl().changeStatusTicket(idTicket, status);
      isLoading = true;
      notifyListeners();
      // await loadData();
    } on DioError catch (e, s) {
      log('Erro ao alterar status do ticket', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao alterar status do ticket');
    }
  }
}
