import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/dto/student_authorization.dart';
import 'package:project_ifma_ticket/features/models/authorization.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';

class CaeAuthorizationController extends ChangeNotifier {
  List<Authorization>? authorizations = [];
  /* Listas de filtros das searchs */
  List<StudentAuthorization> filteredAuthorizations = [];
  List<String> filteredClasses = [];
  List<User> filteredStudents = [];
  /* Maps para armazenamento das turmas */
  Map<String, Map<String, List<Authorization>>> authorizationClasses = {};
  Map<String, Map<String, List<Authorization>>> sortedAuthorizationClasses = {};
  /* Variáveis responsáveis pela seleção na tela evaluate */
  bool selectAll = true;
  List<StudentAuthorization> selectedAuthorizations = [];
  /* Lista de estudantes */
  List<User> listStudents = [];
  bool isLoading = true;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  /// Função que retorna os tickets permanente
  Future<void> loadDataAuthorizations() async {
    try {
      authorizations!.clear();

      authorizationClasses.clear();

      sortedAuthorizationClasses.clear();

      filteredClasses.clear();
      isLoading = true;

      final tickets = await TicketsApiRepositoryImpl().findAllNotAuthorized();

      authorizations = tickets;

      authorizations?.forEach(
        (element) => log(element.toString()),
      );

      String authorizationClassName = '';
      String studentName = '';

      authorizations?.forEach((element) {
        authorizationClassName =
            element.student.substring(0, element.student.length - 4);

        studentName = element.student;

        if (authorizationClasses.containsKey(authorizationClassName)) {
          if (authorizationClasses[authorizationClassName]!
              .containsKey(studentName)) {
            authorizationClasses[authorizationClassName]![studentName]!
                .add(element);
          } else {
            authorizationClasses[authorizationClassName]![studentName] = [
              element
            ];
          }
        } else {
          authorizationClasses[authorizationClassName] = {
            studentName: [element]
          };
        }
      });

      sortedAuthorizationClasses = Map.fromEntries(authorizationClasses.entries
          .toList()
        ..sort((element1, element2) => element1.key.compareTo(element2.key)));
      filteredClasses.addAll(sortedAuthorizationClasses.keys.toList());
      log("dailyClasses :: ${sortedAuthorizationClasses.toString()}");
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

    var sortedList = sortedAuthorizationClasses.keys.toList();

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

  /// Função responsavel por controlar as seleções de todos
  void isSelected(List<StudentAuthorization> students) {
    selectedAuthorizations.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selectedAuthorizations.addAll(students);
    }

    log(selectedAuthorizations.toString());
    notifyListeners();
  }

  /// Função responsavel por filtrar os tickets na tela de turmas
  void filterAuthorizations(String query, List<StudentAuthorization> students) {
    filteredAuthorizations.clear();
    notifyListeners();

    if (query.isNotEmpty) {
      List<StudentAuthorization> tmpList = [];
      for (var item in students) {
        if (item.matricula.contains(query.toUpperCase())) {
          log(query);
          tmpList.add(item);
        }
      }

      filteredAuthorizations.addAll(tmpList);

      notifyListeners();
    } else {
      filteredAuthorizations.addAll(students);
      notifyListeners();
    }
  }

  /// Função responsavel por controlar as seleções individuais
  void verifySelected(
      StudentAuthorization filteredAuthorizations, int allTicketsLength) {
    if (selectedAuthorizations.contains(filteredAuthorizations)) {
      selectedAuthorizations.removeWhere(
        (ts) => ts.matricula == filteredAuthorizations.matricula,
      );
    } else {
      selectedAuthorizations.add(filteredAuthorizations);
    }

    if (allTicketsLength == selectedAuthorizations.length) {
      selectAll = true;
    } else {
      selectAll = false;
    }

    notifyListeners();
  }

  /// Atualização de listas de autorizações pós mudança de status
  void updateClasses(List<String> list, int index) {
    // sortedAuthorizationClasses.values.elementAt(index).clear();

    log("sortedDailyClasses :: ${sortedAuthorizationClasses.toString()}");

    if (list.isNotEmpty) {
      for (String student in list) {
        bool hasKey = sortedAuthorizationClasses.values
            .elementAt(index)
            .containsKey(student);
        if (hasKey) {
          sortedAuthorizationClasses.values.elementAt(index).remove(student);
          filteredAuthorizations
              .removeWhere((element) => element.matricula == student);
        }
        log("RemoveClasses :: ${sortedAuthorizationClasses.toString()}");
        // sortedAuthorizationClasses[index]![student.matricula];
      }
    }

    // if (list.isNotEmpty) {
    //   sortedAuthorizationClasses[filteredClasses[index]]!
    //       .values
    //       .elementAt(index)
    //       .addAll(list);
    // } else {
    //   filteredClasses.remove(sortedAuthorizationClasses.keys.elementAt(index));
    //   sortedAuthorizationClasses[filteredClasses[index]]!
    //       .remove(sortedAuthorizationClasses.keys.elementAt(index));
    // }
    // for (var element in filteredClasses) {
    //   log(element.toString());
    // }

    log("sortedAuthorizationClasses :: ${sortedAuthorizationClasses.toString()}");
    notifyListeners();
  }

  /// Concatena dias
  String getDays(List<Authorization> list) {
    String days = '(';
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        days = '$days${list[0].day()}';
      } else {
        days = '$days, ${list[i].day()}';
      }
    }
    return '$days)';
  }

  /// Atualiza as listas
  void authorizationsList(Map<String, List<Authorization>> authorizations) {
    for (int index = 0; index < authorizations.keys.length; index++) {
      StudentAuthorization studentAuthorization = StudentAuthorization(
          matricula: authorizations.keys.elementAt(index),
          idStudent:
              authorizations[authorizations.keys.elementAt(index)]!.first.id,
          justification: authorizations[authorizations.keys.elementAt(index)]!
              .first
              .justification,
          meal:
              authorizations[authorizations.keys.elementAt(index)]!.first.meal,
          days: getDays(authorizations[authorizations.keys.elementAt(index)]!));
      filteredAuthorizations.add(studentAuthorization);
      selectedAuthorizations.add(studentAuthorization);
    }
  }
}
