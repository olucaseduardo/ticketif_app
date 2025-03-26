import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/repositories/student/profile/profile_api_repository.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';

class NewSolicitationPhotoStudentController extends ChangeNotifier {
  XFile? _picture;

  XFile? get picture => _picture;

  List<PhotoRequestModel> photoRequests = [];
  bool isLoading = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadData() async {}

  // Future<XFile?> _processImageInIsolate(XFile imageFile) async {
  //   // Usa `compute` para processar a imagem em segundo plano
  //   return await compute(_processImage, imageFile);
  // }

  // static Future<XFile?> _processImage(XFile imageFile) async {
  //   try {
  //     final imageBytes = await imageFile.readAsBytes();
  //     final img = decodeImage(imageBytes);

  //     if (img != null) {
  //       final flippedImage = flipHorizontal(img);
  //       final correctedImageBytes = encodePng(flippedImage);

  //       // Salva a imagem processada em um arquivo temporário
  //       final tempDir = Directory.systemTemp;
  //       final tempFile = File('${tempDir.path}/processed_image.png');
  //       await tempFile.writeAsBytes(correctedImageBytes);

  //       return XFile(tempFile.path);
  //     }
  //   } catch (e) {
  //     debugPrint("Erro ao processar a imagem: $e");
  //   }

  //   return null;
  // }

  Future<void> updatePicture(XFile? picture) async {
    if (picture != null) {
      final imageFile = File(picture.path);
      final imageBytes = await imageFile.readAsBytes();
      final img = decodeImage(imageBytes);
      if (img != null) {
        final flippedImage = flipHorizontal(img);
        final correctedImageFile = File(picture.path);
        await correctedImageFile.writeAsBytes(encodePng(flippedImage));
        picture = XFile(correctedImageFile.path);
      }
    }
    _picture = picture;
    notifyListeners();
  }

  Future<void> sendSolicitation() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final registration = sp.getString("matricula");
      if (registration == null || _picture == null) {
        return;
      }
      await ProfileApiRepositoryImpl()
          .sendPhotoRequest(registration, _picture!);
      AppMessage.i.showMessage(
          "Solicitação realizada com sucesso, aguarde a aprovação");
    } on RepositoryException catch (e) {
      AppMessage.i.showError(e.message);
    } on Exception catch (e, s) {
      log("Erro ao realizar a requisição para a troca de foto: ",
          error: e, stackTrace: s);
      AppMessage.i
          .showError("Falha na solicitação, tente novamente mais tarde");
    }
  }
}
