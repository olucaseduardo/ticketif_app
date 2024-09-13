import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository_impl.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';

class CaeController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  /// Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<void> loadLink() async {
    await Links.i.loadLink();
  }

  Future<void> deleteAllPermanents() async {
    try {
      isLoading = true;
      error = false;
      notifyListeners();

      await TicketsApiRepositoryImpl().deleteAllPermanents();

      loading();
    } catch (e, s) {
      log('Erro ao deletar todos os permanentes', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  Future<void> deleteAllTickets() async {
    try {
      isLoading = true;
      error = false;
      notifyListeners();

      await TicketsApiRepositoryImpl().deleteAllTickets();

      loading();
    } catch (e, s) {
      log('Erro ao deletar todos os tickets', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }

  Future<void> deleteAllStudents() async {
    try {
      isLoading = true;
      error = false;
      notifyListeners();

      await CaeRepositoryImpl().deleteAllStudents();

      loading();
    } catch (e, s) {
      log('Erro ao deletar todos os alunos', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }
}
