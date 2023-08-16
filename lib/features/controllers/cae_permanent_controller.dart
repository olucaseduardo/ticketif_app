import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/authorization.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';

class CaePermanentController extends ChangeNotifier {
  List<Authorization>? authorizations = [];
  /* Listas de filtros das searchs */
  List<Authorization> filteredAuthorizations = [];
  List<String> filteredClasses = [];
  List<User> filteredStudents = [];
  /* Maps para armazenamento das turmas */
  Map<String, Map<String, List<Authorization>>> authorizationClasses = {};
  Map<String, Map<String, List<Authorization>>> sortedAuthorizationClasses = {};
  /* Variáveis responsáveis pela seleção na tela evaluate */
  bool selectAll = true;
  List<Authorization> selectedAuthorizatons = [];
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
  void isSelected(List<Authorization> tickets) {
    selectedAuthorizatons.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selectedAuthorizatons.addAll(tickets);
    }

    log(selectedAuthorizatons.toString());
    notifyListeners();
  }

  /// Função responsavel por filtrar os tickets na tela de turmas
  void filterAuthorizations(String query, List<Authorization> tickets) {
    filteredAuthorizations.clear();
    notifyListeners();

    if (query.isNotEmpty) {
      List<Authorization> tmpList = [];
      for (var item in tickets) {
        if (item.student.contains(query.toUpperCase())) {
          tmpList.add(item);
        }
      }

      filteredAuthorizations.addAll(tmpList);

      notifyListeners();
    } else {
      filteredAuthorizations.addAll(tickets);
      notifyListeners();
    }
  }

  /// Função responsavel por controlar as seleções individuais
  void verifySelected(
      Authorization filteredAuthorizations, int allTicketsLength) {
    if (selectedAuthorizatons.contains(filteredAuthorizations)) {
      selectedAuthorizatons.removeWhere(
        (ts) => ts.id == filteredAuthorizations.id,
      );
    } else {
      selectedAuthorizatons.add(filteredAuthorizations);
    }

    if (allTicketsLength == selectedAuthorizatons.length) {
      selectAll = true;
    } else {
      selectAll = false;
    }

    notifyListeners();
  }

  /// Atualização de listas de tickets pós mudança de status
  void updateClasses(List<Authorization> list, int index) {
    sortedAuthorizationClasses.values.elementAt(index).clear();

    log("sortedDailyClasses :: ${sortedAuthorizationClasses.toString()}");
    if (list.isNotEmpty) {
      sortedAuthorizationClasses[filteredClasses[index]]!
          .values
          .elementAt(index)
          .addAll(list);
    } else {
      filteredClasses.remove(sortedAuthorizationClasses.keys.elementAt(index));
      sortedAuthorizationClasses[filteredClasses[index]]!
          .remove(sortedAuthorizationClasses.keys.elementAt(index));
    }
    for (var element in filteredClasses) {
      log(element.toString());
    }

    log("sortedAuthorizationClasses :: ${sortedAuthorizationClasses.toString()}");
    notifyListeners();
  }
}
// {
//         "id": 6,
//         "student_id": 1,
//         "meal_id": 2,
//         "week_id": 2,
//         "justification_id": 1,
//         "authorized": 0,
//         "student": "20191BCC.CAX0001",
//         "student_name": "Fulano Bezerra",
//         "justification_description": "Contra-turno",
//         "meal_description": "Almoço",
//         "type": "Superior"
//     },
    // {
    //     "id": 8,
    //     "student_id": 6,
    //     "meal_id": 2,
    //     "week_id": 1,
    //     "justification_id": 2,
    //     "authorized": 0,
    //     "student": "20191BCC.CAX0005",
    //     "student_name": "Luis",
    //     "justification_description": "Monitoria",
    //     "meal_description": "Almoço",
    //     "type": "Superior"
    // },
    // {
    //     "id": 9,
    //     "student_id": 6,
    //     "meal_id": 2,
    //     "week_id": 2,
    //     "justification_id": 2,
    //     "authorized": 0,
    //     "student": "20191BCC.CAX0005",
    //     "student_name": "Luis",
    //     "justification_description": "Monitoria",
    //     "meal_description": "Almoço",
    //     "type": "Superior"
    // }