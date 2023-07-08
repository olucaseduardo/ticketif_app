import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/repositories/user/user_api_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaeController extends ChangeNotifier {
  List<Ticket>? dailyTickets = [];
  /* Listas de filtros das searchs */
  List<Ticket> filtered = [];
  List<String> filteredClasses = [];
  List<User> filteredStudents = [];
  /* Maps para armazenamento das turmas */
  Map<String, List<Ticket>> dailyClasses = {};
  /* Variáveis responsáveis pela seleção na tela evaluate */
  bool selectAll = true;
  List<Ticket> selected = [];
  /* Lista de estudantes */
  List<User> listStudents = [];

  bool isLoading = true;
  bool error = false;

  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> loadStudents() async {
    try {
      listStudents.clear();
      filteredStudents.clear();
      isLoading = true;

      final students = await UserApiRepositoryImpl().findAllStudents();

      students.sort(
        (name1, name2) => name1.name.compareTo(name2.name),
      );

      listStudents = students;
      filteredStudents = students;

      loading();
    } catch (e, s) {
      log('Erro ao buscar os estudantes', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  Future<void> loadDataTickets(
      {required String date, required bool isPermanent}) async {
    try {
      dailyTickets!.clear();

      dailyClasses.clear();

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

        log(dailyClasses.toString());
      });

      var sortedList = dailyClasses.keys.toList();

      sortedList.sort();
      filteredClasses.addAll(sortedList);

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
      isLoading = false;

      selected.removeWhere((t) => t.id == idTicket);
      filtered.removeWhere((t) => t.id == idTicket);
      dailyTickets?.removeWhere((t) => t.id == idTicket);

      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao alterar status do ticket', error: e, stackTrace: s);
      isLoading = false;
      throw RepositoryException(message: 'Erro ao alterar status do ticket');
    }
  }

  /* Função responsavel por filtrar os tickets na tela de turmas */
  void filterTickets(String query, List<Ticket> tickets) {
    filtered.clear();
    notifyListeners();

    if (query.isNotEmpty) {
      List<Ticket> tmpList = [];
      for (var item in tickets) {
        if (item.student.contains(query.toUpperCase())) {
          tmpList.add(item);
        }
      }

      filtered.addAll(tmpList);

      notifyListeners();
    } else {
      filtered.addAll(tickets);
      notifyListeners();
    }
  }

  void filterClasses(String query) {
    filteredClasses.clear();
    notifyListeners();

    var sortedList = dailyClasses.keys.toList();
    sortedList.sort();

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

  /* Funções responsaveis por controlar as seleções */
  void isSelected(List<Ticket> tickets) {
    selected.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selected.addAll(tickets);
    }

    log(selected.toString());
    notifyListeners();
  }

  void verifySelected(Ticket filteredTickets, int allTicketsLength) {
    if (selected.contains(filteredTickets)) {
      selected.removeWhere(
        (ts) => ts.id == filteredTickets.id,
      );
    } else {
      selected.add(filteredTickets);
    }

    if (allTicketsLength == selected.length) {
      selectAll = true;
    } else {
      selectAll = false;
    }

    notifyListeners();
  }

  /* Realização de solicitações */
  void solicitation(int status) {
    isLoading = true;
    notifyListeners();

    if (status == 4) {
      log('sel ${selected.toString()}');
      for (var element in selected) {
        changeTicketCAE(element.id, status);
      }
    } else {
      for (var element in selected) {
        changeTicketCAE(element.id, status);
      }
    }
  }

  void updateClasses(List<Ticket> list, int index) {
    dailyClasses.values.elementAt(index).clear();

    if (list.isNotEmpty) {
      dailyClasses.values.elementAt(index).addAll(list);
    } else {
      filteredClasses.remove(dailyClasses.keys.elementAt(index));
      dailyClasses.remove(dailyClasses.keys.elementAt(index));
    }
    notifyListeners();
  }

  /* Filtragem de estudantes */
  void searchStudent(String searchText) {
    filteredStudents = listStudents
        .where((student) =>
            student.matricula.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
