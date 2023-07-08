import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';

class ReportController extends ChangeNotifier {
  List<Ticket>? dailyTickets = [];
  Map<String, Map<String, List<Ticket>>> dailyStatus = {};

  bool isLoading = true;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> loadDailyTickets({required String date}) async {
    try {
      dailyTickets!.clear();
      dailyStatus.clear();
      isLoading = true;

      final tickets =
          await TicketsApiRepositoryImpl().findAllDailyTickets(date);
      for (var index = 0; index < tickets.length; index++) {
        dailyTickets?.add(tickets.elementAt(index));
      }
      dailyTickets?.forEach(
        (element) => log(element.toString()),
      );
      String statusName = '';
      String mealName = '';
      dailyTickets?.forEach((element) {
        statusName = element.status;
        mealName = '${element.meal} - ${element.type}';
        if (dailyStatus.containsKey(statusName)) {
          if (dailyStatus[statusName]!.containsKey(mealName)) {
            dailyStatus[statusName]![mealName]!.add(element);
          } else {
            dailyStatus[statusName]![mealName] = [element];
          }
        } else {
          dailyStatus[statusName] = {};
          dailyStatus[statusName]?[mealName] = [element];
        }
        log(dailyStatus.toString());
      });

      loading();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }
}
