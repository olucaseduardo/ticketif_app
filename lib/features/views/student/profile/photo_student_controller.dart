import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:ticket_ifma/features/cache/student_cache.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/repositories/student/profile/profile_api_repository.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';

class PhotoStudentController extends ChangeNotifier {
  bool imageIsValid = false;
  String? imgURL;
  User? user;

  List<PhotoRequestModel> photoRequests = [];
  bool isLoading = false;

  loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  loadData() async {
    user = await UserCache.getUser();
    if (user == null) {
      return;
    }
    imgURL = getImageUrlStudent(user!.registration);
    notifyListeners();

    photoRequests.clear();

    try {
      loading();
      final registration =
          (await SharedPreferences.getInstance()).getString("matricula");
      if (registration == null) {
        AppMessage.i.showError(
            "Falha ao buscar solicitações, tente novamente mais tarde");
        return;
      }
      photoRequests = await ProfileApiRepositoryImpl()
          .getStudentPhotoRequests(registration);
      photoRequests.sort((a, b) {
        if (a.status == PhotoRequestModel.analysis && b.status != PhotoRequestModel.analysis) {
          return -1;
        } else if (a.status != PhotoRequestModel.analysis && b.status == PhotoRequestModel.analysis) {
          return 1;
        } else {
          return 0;
        }
      });    } catch (e, s) {
      log("Erro ao realizar a requisição para a troca de foto: ",
          error: e, stackTrace: s);
      AppMessage.i
          .showError("Erro ao buscar solicitações, tente novamente mais tarde");
    } finally {
      loading();
    }
    // imageIsValid = await CacheManagerUtil().isImageUrlValid(imgURL!);
  }

  cancelRequestPhoto(int id) async {
    try {
      await ProfileApiRepositoryImpl().updatePhotoRequest(id, "Cancelado");
      AppMessage.i.showMessage("Solicitação cancelada com sucesso");
    } catch (e) {
      AppMessage.i.showError("Erro ao cancelar solicitação, tente novamente mais tarde");
    }
    loadData();
  }

  String getImageUrlStudent(String registration) {
    return "${Links.i.selectedLink}/student/$registration/photo";
  }
}
