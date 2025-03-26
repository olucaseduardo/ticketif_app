import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/class.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository_impl.dart';

class AddNewClassController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  List<Class> classes = [];
  String? selectedCourse;
  Map<String, String> coursesMap = {
    'adm': 'Administração',
    'agroind': 'Agroindústria',
    'agropec': 'Agropecuária',
    'com': 'Comércio',
    'info': 'Informática'
  };
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

  Future<void> loadData() async {
    try {
      await findAllClasses();
    } catch (e, s) {
      log('Erro ao iniciar tela de novas turmas', error: e, stackTrace: s);
      error = true;
    }
    // loading();
  }

  Map<String, String> _convertMap() {
    return {for (var course in courses) course.keys.first: course.values.first};
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

  Future<void> findAllClasses() async {
    try {
      isLoading = true;
      error = false;
      notifyListeners();
      classes.clear();
      classes = await CaeRepositoryImpl().findAllClass();

      loading();
    } catch (e, s) {
      log('Erro ao buscar as turmas', error: e, stackTrace: s);
      loading();
      error = true;
      notifyListeners();
    }
  }
}
