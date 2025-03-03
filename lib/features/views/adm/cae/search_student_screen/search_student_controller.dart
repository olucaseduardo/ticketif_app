import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/repositories/user/user_api_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchStudentController extends ChangeNotifier {
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

  /// Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void loading() {
    isLoading = !isLoading;
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

  /// Filtragem de estudantes
  void searchStudent(String searchText) {
    debugPrint(searchText);
    filteredStudents = listStudents
        .where((student) =>
            student.matricula.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
