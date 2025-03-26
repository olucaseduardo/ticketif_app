import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:share_plus/share_plus.dart';

class PeriodReportController extends ChangeNotifier {
  List<Ticket>? dailyTickets = [];
  Map<String, Map<String, List<Ticket>>> dailyStatus = {};

  DateTime day = DateUtil.dateTimeNow;

  bool isLoading = true;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> exportCSV() async {
    Map<String, int> reportMap = {};
    List<List<dynamic>> rows = [];

    rows.add(
        ["DATA", "DIA", "REFEIÇÃO", "PÚBLICO", "QUANTIDADE", "VALOR", "TOTAL"]);

    for (Ticket ticket in dailyTickets!) {
      String key =
          '${ticket.useDayDate.substring(0, 10)}|${ticket.useDay}|${ticket.meal}|${ticket.type}';

      if (reportMap.containsKey(key)) {
        reportMap[key] = (reportMap[key]! + 1);
      } else {
        reportMap[key] = 1;
      }
    }

    var keyList = reportMap.keys.toList();
    keyList.sort();
    double totalCost = 0;
    int totalMeal = 0;
    Set<String> days = {};

    for (var key in keyList) {
      final keyInfo = key.split('|');
      days.add(keyInfo[0]);
      DateTime date = DateTime.parse(keyInfo[0]);
      final dateStr = keyInfo[1];
      final meal = keyInfo[2];
      final typeStudent = keyInfo[3];
      double price = keyInfo[3] == 'Superior' ? 10.0 : 11.25;
      double sum = reportMap[key]! * price;
      totalCost += sum;
      totalMeal += reportMap[key]!;
      rows.add([
        DateUtil.getDateStr(date),
        dateStr,
        meal,
        typeStudent,
        reportMap[key],
        price,
        sum
      ]);
    }

    rows.add(['', '', '', '', '', 'TOTAL', totalCost]);
    rows.add(['', '', '', '', '', '', '']);
    rows.add(['DIAS', days.length, '', '', '', '', '']);
    rows.add(['QNT. REFEIÇÕES', totalMeal, '', '', '', '', '']);
    String csvData = const ListToCsvConverter().convert(rows);

    final directory = (await getApplicationDocumentsDirectory()).path;
    final path =
        "$directory/Relatorio-Ticket-${DateTime.now().toString().substring(0, 10)}.csv";
    final File file = File(path);
    await file.writeAsString(csvData);
    Share.shareXFiles([XFile(file.path)], subject: 'Relatorio Tickets');
  }

  Future<void> loadPeriodTickets(
      {required String initialDate, required String finalDate}) async {
    try {
      dailyTickets!.clear();
      dailyStatus.clear();
      isLoading = true;

      final tickets = await TicketsApiRepositoryImpl()
          .findPeriodTickets(initialDate, finalDate);

      dailyTickets?.addAll(tickets);

      // for (var index = 0; index < tickets.length; index++) {
      //   if (tickets.elementAt(index).idStatus == 5) {
      //     dailyTickets?.add(tickets.elementAt(index));
      //   }
      // }

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
      });

      loading();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  void updatePeriodTickets(DateTime? pickDateInitial, DateTime? pickDateFinal) {
    if (pickDateInitial != null && pickDateFinal != null) {
      loading();

      loadPeriodTickets(
        initialDate: DateUtil.getDateUSStr(pickDateInitial),
        finalDate: DateUtil.getDateUSStr(pickDateFinal),
      );
    }
  }
}
