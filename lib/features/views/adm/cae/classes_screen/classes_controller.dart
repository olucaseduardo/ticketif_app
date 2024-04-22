import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';

class ClassesController extends ChangeNotifier {
  List<Ticket>? dailyTickets = [];
  /* Listas de filtros das searchs */
  List<Ticket> filteredTickets = [];
  List<String> filteredClasses = [];
  List<User> filteredStudents = [];
  /* Maps para armazenamento das turmas */
  Map<String, List<Ticket>> dailyClasses = {};
  Map<String, List<Ticket>> sortedDailyClasses = {};
  /* Variáveis responsáveis pela seleção na tela evaluate */
  bool selectAll = true;
  List<Ticket> selectedTickets = [];
  /* Lista de estudantes */
  List<User> listStudents = [];

  bool isLoading = true;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  /// Função que retorna os tickets de um determinado dia
  Future<void> loadDataTickets(
      {required String date, required bool isPermanent}) async {
    try {
      dailyTickets!.clear();

      dailyClasses.clear();

      sortedDailyClasses.clear();

      filteredClasses.clear();
      isLoading = true;

      final tickets =
          await TicketsApiRepositoryImpl().findAllDailyTickets(date);
      log("isPermanent :: $isPermanent");
      if (!isPermanent) {
        dailyTickets = tickets
            .where(
                (element) => element.isPermanent == 0 && element.idStatus == 1)
            .toList();
      } else {
        dailyTickets = tickets
            .where(
                (element) => element.isPermanent == 1 && element.idStatus == 1)
            .toList();
      }

      dailyTickets?.forEach(
        (element) => log(element.toString()),
      );

      String dailyClassName = '';

      dailyTickets?.forEach((element) {
        dailyClassName =
            element.student.substring(0, element.student.length - 4);
        if (dailyClasses.containsKey(dailyClassName)) {
          dailyClasses[dailyClassName]!.add(element);
        } else {
          dailyClasses[dailyClassName] = [element];
        }
      });

      sortedDailyClasses = Map.fromEntries(dailyClasses.entries.toList()
        ..sort((element1, element2) => element1.key.compareTo(element2.key)));
      filteredClasses.addAll(sortedDailyClasses.keys.toList());
      log("dailyClasses :: ${sortedDailyClasses.toString()}");
      loading();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  /// Função responsável por filtrar as turmas
  void filterClasses(String query) {
    filteredClasses.clear();
    notifyListeners();

    var sortedList = sortedDailyClasses.keys.toList();

    if (query.isNotEmpty) {
      List<String> tmpList = [];
      for (var item in sortedList) {
        if (item.contains(query.toUpperCase())) {
          tmpList.add(item);
        }
      }

      filteredClasses.addAll(tmpList);

      notifyListeners();
    } else {
      filteredClasses.addAll(sortedList);
      notifyListeners();
    }
  }

  /// Atualização de listas de tickets pós mudança de status
  void updateClasses(List<Ticket> list, int index) {
    sortedDailyClasses.values.elementAt(index).clear();

    log("sortedDailyClasses :: ${sortedDailyClasses.toString()}");
    if (list.isNotEmpty) {
      sortedDailyClasses.values.elementAt(index).addAll(list);
    } else {
      filteredClasses.remove(sortedDailyClasses.keys.elementAt(index));
      sortedDailyClasses.remove(sortedDailyClasses.keys.elementAt(index));
    }
    for (var element in filteredClasses) {
      log(element.toString());
    }

    log("sortedDailyClasses :: ${sortedDailyClasses.toString()}");
    notifyListeners();
  }
}
