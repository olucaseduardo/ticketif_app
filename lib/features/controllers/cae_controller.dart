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

  ///Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  /// Função que carrega os dados dos estudantes
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

  /// Função que atualiza o status do ticket
  Future<void> changeTicketCAE(int idTicket, int status) async {
    try {
      await TicketsApiRepositoryImpl().changeStatusTicket(idTicket, status);
      isLoading = false;

      selectedTickets.removeWhere((t) => t.id == idTicket);
      filteredTickets.removeWhere((t) => t.id == idTicket);
      dailyTickets?.removeWhere((t) => t.id == idTicket);

      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao alterar status do ticket', error: e, stackTrace: s);
      isLoading = false;
      throw RepositoryException(message: 'Erro ao alterar status do ticket');
    }
  }

  ///Função responsavel por filtrar os tickets na tela de turmas
  void filterTickets(String query, List<Ticket> tickets) {
    filteredTickets.clear();
    notifyListeners();

    if (query.isNotEmpty) {
      List<Ticket> tmpList = [];
      for (var item in tickets) {
        if (item.student.contains(query.toUpperCase())) {
          tmpList.add(item);
        }
      }

      filteredTickets.addAll(tmpList);

      notifyListeners();
    } else {
      filteredTickets.addAll(tickets);
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

  /* Funções responsaveis por controlar as seleções */
  void isSelected(List<Ticket> tickets) {
    selectedTickets.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selectedTickets.addAll(tickets);
    }

    log(selectedTickets.toString());
    notifyListeners();
  }

  void verifySelected(Ticket filteredTickets, int allTicketsLength) {
    if (selectedTickets.contains(filteredTickets)) {
      selectedTickets.removeWhere(
        (ts) => ts.id == filteredTickets.id,
      );
    } else {
      selectedTickets.add(filteredTickets);
    }

    if (allTicketsLength == selectedTickets.length) {
      selectAll = true;
    } else {
      selectAll = false;
    }

    notifyListeners();
  }

  /// Realização de solicitações
  void solicitation(int status) {
    isLoading = true;
    notifyListeners();

    if (status == 4) {
      log('sel ${selectedTickets.toString()}');
      for (var element in selectedTickets) {
        changeTicketCAE(element.id, status);
      }
    } else {
      for (var element in selectedTickets) {
        changeTicketCAE(element.id, status);
      }
    }
  }

  ///Atualização de listas de tickets pós mudança de status
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

  /// Filtragem de estudantes
  void searchStudent(String searchText) {
    filteredStudents = listStudents
        .where((student) =>
            student.matricula.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
