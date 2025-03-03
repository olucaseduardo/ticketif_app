import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository_impl.dart';

class AddNewClassController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  String? selectedCourse;
  List<Map<String, String>> courses = [
    {'Administração': 'adm'},
    {'Agroindústria': 'agroind'},
    {'Agropecuária': 'agropec'},
    {'Comércio': 'com'},
    {'Informática': 'info'},
  ];

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Map<String, String> _convertMap() {
    return {
      for (var course in courses) course.keys.first: course.values.first
    };
  }

  void selectCourse(String? value) {
    Map<String, String> courseMap = _convertMap();
    selectedCourse = courseMap[value];
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
