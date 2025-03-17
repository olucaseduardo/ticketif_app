import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/authorization.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';

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
  bool selectAllStudent = true;
  List<StudentAuthorization> selectedAuthorizations = [];

  /* Lista de estudantes */
  List<User> listStudents = [];
  bool isLoading = true;
  bool error = false;

  /* Lista de Tickets Selecionados Do Estudante */
  List<int> selectedAuthorizationsStudent = [];

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  /// Função que retorna os tickets permanente
  Future<void> loadDataAuthorizations() async {
    try {
      _clearData();

      isLoading = true;

      final tickets =
          await TicketsApiRepositoryImpl().findAllInAnalisePermanents();

      authorizations = tickets;

      _processAuthorizations();

      loading();
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  Future<void> changedAuthorizations(int status) async {
    try {
      for (var element in selectedAuthorizations) {
        await TicketsApiRepositoryImpl()
            .changeStatusAuthorizationPermanents(element.ticketsIds, status);
      }
    } on DioError catch (e, s) {
      log('Erro ao atualizar autorização permanente', error: e, stackTrace: s);

      error = true;
      notifyListeners();
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao atualizar autorização', error: e, stackTrace: s);
    }
  }

  Future<void> changedAuthorizationStudent(int status) async {
    try {
      await TicketsApiRepositoryImpl().changeStatusAuthorizationPermanents(
          selectedAuthorizationsStudent, status);
    } on DioError catch (e, s) {
      log('Erro ao atualizar autorização permanente', error: e, stackTrace: s);

      error = true;
      notifyListeners();
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao atualizar autorização', error: e, stackTrace: s);
    }
  }

  ///função para limpar as listas
  void _clearData() {
    authorizations!.clear();

    authorizationClasses.clear();

    sortedAuthorizationClasses.clear();

    filteredClasses.clear();
  }

  ///função de processamento de dados
  _processAuthorizations() {
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

    sortedAuthorizationClasses = Map.fromEntries(
        authorizationClasses.entries.toList()
          ..sort((element1, element2) => element1.key.compareTo(element2.key)));
    filteredClasses.addAll(sortedAuthorizationClasses.keys.toList());
  }

  ///Função de error
  void _handleError(dynamic error, StackTrace stackTrace) {
    log('Erro ao buscar dados', error: error, stackTrace: stackTrace);
    loading();
    error = true;
    notifyListeners();
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

    notifyListeners();
  }

  void isSelectedAuthorizationStudent(List<int> ticketsId) {
    selectedAuthorizationsStudent.clear();
    selectAllStudent = !selectAllStudent;

    if (selectAllStudent) {
      selectedAuthorizationsStudent.addAll(ticketsId);
    }

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
        (ts) =>
            ts.matricula == filteredAuthorizations.matricula &&
            ts.mealId == filteredAuthorizations.mealId,
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

  void verifySelectedAuthorizationStudent(int id, int allTicketsLength) {
    if (selectedAuthorizationsStudent.contains(id)) {
      selectedAuthorizationsStudent.removeWhere(
        (selectedId) => selectedId == id,
      );
    } else {
      selectedAuthorizationsStudent.add(id);
    }
    if (allTicketsLength == selectedAuthorizationsStudent.length) {
      selectAllStudent = true;
    } else {
      selectAllStudent = false;
    }

    notifyListeners();
  }

  /// Atualização de listas de autorizações pós mudança de status
  void updateClasses(List<List<String>> list, int index) {
    // sortedAuthorizationClasses.values.elementAt(index).clear();
    final registration = list[0][0];
    final classStudent = registration.substring(0, registration.length - 4);
    if (list.isNotEmpty && !error) {
      for (List<String> student in list) {
        bool hasKey = sortedAuthorizationClasses.values
            .elementAt(index)
            .containsKey(student[0]);
        if (hasKey) {
          sortedAuthorizationClasses.values
              .elementAt(index)[student[0]]!
              .removeWhere((element) =>
                  element.student == student[0] && element.meal == student[1]);
          filteredAuthorizations.removeWhere((element) =>
              element.matricula == student[0] && element.meal == student[1]);
        }
        if (sortedAuthorizationClasses.values
            .elementAt(index)[student[0]]!
            .isEmpty) {
          sortedAuthorizationClasses.values.elementAt(index).remove(student[0]);
        }
      }
      if (authorizationClasses[classStudent] != null &&
          authorizationClasses[classStudent]!.isEmpty) {
        filteredClasses.remove(classStudent);
      }
    }
    notifyListeners();
  }

  void updateAuthorizationsStudent(List<int> list, int index) {
    if (list.isNotEmpty && !error) {
      final authorizationStudent = filteredAuthorizations[index];
      final classStudent = authorizationStudent.matricula
          .substring(0, authorizationStudent.matricula.length - 4);
      for (int ticketId in list) {
        bool hasId =
            filteredAuthorizations[index].ticketsIds.contains(ticketId);
        if (hasId) {
          int indexId =
              filteredAuthorizations[index].ticketsIds.indexOf(ticketId);
          filteredAuthorizations[index].ticketsIds.remove(ticketId);
          filteredAuthorizations[index].listDays.removeAt(indexId);
          authorizationClasses[classStudent]?[authorizationStudent.matricula]
              ?.removeWhere((e) => e.id == ticketId);
        }
      }
      if (filteredAuthorizations[index].ticketsIds.isEmpty) {
        filteredAuthorizations.removeAt(index);
      }
      if (authorizationClasses[classStudent]?[authorizationStudent.matricula] !=
              null &&
          authorizationClasses[classStudent]![authorizationStudent.matricula]!
              .isEmpty) {
        authorizationClasses[classStudent]!
            .remove(authorizationStudent.matricula);
      }
      if (authorizationClasses[classStudent] != null &&
          authorizationClasses[classStudent]!.isEmpty) {
        filteredClasses.remove(classStudent);
      }
    }
    notifyListeners();
  }

  void clearAuthorizationsStudent() {
    selectedAuthorizationsStudent.clear();
  }

  /// Atualiza as listas
  void authorizationsList(Map<String, List<Authorization>> authorizations) {
    for (int index = 0; index < authorizations.keys.length; index++) {
      String matricula = authorizations.keys.elementAt(index);
      List<Authorization> student = authorizations[matricula]!;

      Map<String, List<Authorization>> meals = {};

      for (int authIndex = 0; authIndex < student.length; authIndex++) {
        Authorization currentAuthorization = student[authIndex];

        if (meals.containsKey(currentAuthorization.meal)) {
          meals[currentAuthorization.meal]!.add(currentAuthorization);
        } else {
          meals[currentAuthorization.meal] = [currentAuthorization];
        }
      }

      // Criação do objeto fora do laço interno

      meals.forEach((meal, mealAuths) {
        StudentAuthorization studentAuthorization = StudentAuthorization(
          listDays: mealAuths.map((e) => e.dayFull()).toList(),
          ticketsIds: mealAuths.map((e) => e.id).toList(),
          matricula: matricula,
          idStudent: student[0].studentId,
          text: student[0].justification,
          mealId: mealAuths[0].mealId,
          meal: meal,
        );

        filteredAuthorizations.add(studentAuthorization);
        selectedAuthorizations.add(studentAuthorization);
      });
    }
  }

  List<StudentAuthorization> studentsAuthorizationsList(
      Map<String, List<Authorization>> authorizations) {
    List<StudentAuthorization> list = [];
    for (int index = 0; index < authorizations.keys.length; index++) {
      String matricula = authorizations.keys.elementAt(index);
      List<Authorization> student = authorizations[matricula]!;

      Map<String, List<Authorization>> meals = {};

      for (int authIndex = 0; authIndex < student.length; authIndex++) {
        Authorization currentAuthorization = student[authIndex];

        if (meals.containsKey(currentAuthorization.meal)) {
          meals[currentAuthorization.meal]!.add(currentAuthorization);
        } else {
          meals[currentAuthorization.meal] = [currentAuthorization];
        }
      }

      // Criação do objeto fora do laço interno

      meals.forEach((meal, mealAuths) {
        StudentAuthorization studentAuthorization = StudentAuthorization(
          listDays: mealAuths.map((e) => e.day()).toList(),
          ticketsIds: student.map((e) => e.id).toList(),
          matricula: matricula,
          idStudent: student[0].studentId,
          text: student[0].justification,
          mealId: mealAuths[0].mealId,
          meal: meal,
        );

        list.add(studentAuthorization);
      });
    }

    return list;
  }
}
