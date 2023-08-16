import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';

class TicketEvaluateController extends ChangeNotifier {
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

  /// Função responsavel por controlar as seleções individuais
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

  /// Função responsavel por controlar as seleções de todos
  void isSelected(List<Ticket> tickets) {
    selectedTickets.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selectedTickets.addAll(tickets);
    }

    log(selectedTickets.toString());
    notifyListeners();
  }

  /// Função responsavel por filtrar os tickets na tela de turmas
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
}
