import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository_impl.dart';

class AddNewClassController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> addClass(String newClass, String course) async {
    try {
      isLoading = true;
      error = false;
      notifyListeners();

      await CaeRepositoryImpl().addNewClass(newClass, course);

      loading();
    } catch (e, s) {
      log('Erro ao inserir nova turma', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }
}
