import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/repositories/student/profile/profile_api_repository.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';

class PhotoRequestAuthorizationController extends ChangeNotifier {
  List<PhotoRequestModel> dailyPhotoRequests = [];

  /* Listas de filtros das searchs */
  List<PhotoRequestModel> filteredPhotoRequests = [];
  List<String> filteredClasses = [];

  // List<User> filteredStudents = [];
  /* Maps para armazenamento das turmas */
  Map<String, List<PhotoRequestModel>> dailyClasses = {};
  Map<String, List<PhotoRequestModel>> sortedDailyClasses = {};

  /* Variáveis responsáveis pela seleção na tela evaluate */
  bool selectAll = true;
  List<PhotoRequestModel> selectedPhotoRequests = [];

  /* Lista de estudantes */
  // List<User> listStudents = [];

  bool isLoading = true;
  bool error = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  /// Função que retorna os tickets de um determinado dia
  Future<void> loadDataPhotoRequests() async {
    try {
      dailyPhotoRequests.clear();

      dailyClasses.clear();

      sortedDailyClasses.clear();

      filteredClasses.clear();
      isLoading = true;

      dailyPhotoRequests = await ProfileApiRepositoryImpl().getPhotoRequests();

      String dailyClassName = '';

      for (var element in dailyPhotoRequests) {
        dailyClassName = element.studentRegistration
            .substring(0, element.studentRegistration.length - 4);
        if (dailyClasses.containsKey(dailyClassName)) {
          dailyClasses[dailyClassName]!.add(element);
        } else {
          dailyClasses[dailyClassName] = [element];
        }
      }

      sortedDailyClasses = Map.fromEntries(dailyClasses.entries.toList()
        ..sort((element1, element2) => element1.key.compareTo(element2.key)));
      filteredClasses.addAll(sortedDailyClasses.keys.toList());
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

  /// Atualização de listas de tickets pós mudança de status
  void updateClasses(List<PhotoRequestModel> list, int index) {
    sortedDailyClasses.values.elementAt(index).clear();

    if (list.isNotEmpty) {
      sortedDailyClasses.values.elementAt(index).addAll(list);
    } else {
      filteredClasses.remove(sortedDailyClasses.keys.elementAt(index));
      sortedDailyClasses.remove(sortedDailyClasses.keys.elementAt(index));
    }

    notifyListeners();
  }

  void filterPhotoRequests(String query, List<PhotoRequestModel> tickets) {
    filteredPhotoRequests.clear();
    notifyListeners();

    if (query.isNotEmpty) {
      List<PhotoRequestModel> tmpList = [];
      for (var item in tickets) {
        if (item.studentRegistration.contains(query.toUpperCase())) {
          tmpList.add(item);
        }
      }

      filteredPhotoRequests.addAll(tmpList);

      notifyListeners();
    } else {
      filteredPhotoRequests.addAll(tickets);
      notifyListeners();
    }
  }

  void isSelected(List<PhotoRequestModel> tickets) {
    selectedPhotoRequests.clear();
    selectAll = !selectAll;

    if (selectAll) {
      selectedPhotoRequests.addAll(tickets);
    }
    notifyListeners();
  }

  void verifySelected(
      PhotoRequestModel filteredPhotoRequests, int allPhotoRequestsLength) {
    if (selectedPhotoRequests.contains(filteredPhotoRequests)) {
      selectedPhotoRequests.removeWhere(
        (ts) => ts.id == filteredPhotoRequests.id,
      );
    } else {
      selectedPhotoRequests.add(filteredPhotoRequests);
    }

    if (allPhotoRequestsLength == selectedPhotoRequests.length) {
      selectAll = true;
    } else {
      selectAll = false;
    }

    notifyListeners();
  }

  String getImageUrl(int id) {
    return "${Links.i.selectedLink}/student/photo/request/$id";
  }

  solicitation(String status) async {
    isLoading = true;
    notifyListeners();
    for (var photoRequest in selectedPhotoRequests) {
      changeStatusRequestPhot(photoRequest.id, status);
    }
    loading();
  }

  changeStatusRequestPhot(int id, status) async {
    try {
      await ProfileApiRepositoryImpl().updatePhotoRequest(id, status);
      dailyPhotoRequests.removeWhere((t) => t.id == id);
      selectedPhotoRequests.removeWhere((t) => t.id == id);
      filteredPhotoRequests.removeWhere((t) => t.id == id);
      notifyListeners();
    } on RepositoryException catch (e) {
      AppMessage.i.showError(e.message);
    } catch (e, s) {
      log("erro ao atualizar", error: e, stackTrace: s);
      AppMessage.i.showError("Erro ao atualizar requisições");
    }
  }
}
