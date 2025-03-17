import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/repositories/student/profile/profile_api_repository_impl.dart';

class ProfileApiRepositoryImpl extends ProfileApiRepository {
  @override
  Future<List<PhotoRequestModel>> getPhotoRequests() async {
    try {
      final response =
          await DioClient().get("/student/photo/request/?situation=Em Análise");
      return List<PhotoRequestModel>.from(response.data["data"]["requests"].map((e) => PhotoRequestModel.fromMap(e)));
    } on DioError catch (e, s) {
      log("Erro no servidor ao buscar solicitações do estudante para troca de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(message: e.message);
    } catch (e, s) {
      log("Erro ao buscar solicitações do estudante para troca de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(
          message:
          "Erro no servidor ao buscar solicitação do estudante para troca de foto de perfil, tente novamente mais tarde");
    }
  }

  @override
  Future<List<PhotoRequestModel>> getStudentPhotoRequests(
      String registration) async {
    try {
      final response =
          await DioClient().get("/student/$registration/photo/request");
      return List<PhotoRequestModel>.from(response.data["data"]["requests"].map((e) => PhotoRequestModel.fromMap(e)));
    } on DioError catch (e, s) {
      log("Erro no servidor ao buscar solicitações do estudante para troca de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, s) {
      log("Erro ao buscar solicitações do estudante para troca de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(
          message:
              "Erro no servidor ao buscar solicitação do estudante para troca de foto de perfil, tente novamente mais tarde");
    }
  }

  @override
  Future<void> sendPhotoRequest(String registration, XFile picture) async {
    try {
      var file = File(picture.path);
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: '$registration.jpeg', contentType: MediaType('image', 'jpeg')),
      });
      await DioClient()
          .post("/student/$registration/photo/request", data: formData);
    } on DioError catch (e, s) {
      log("Erro no servidor ao solicitar mudança de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(message: e.response!.data["message"]!);
    } on Exception catch (e, s) {
      log("Erro ao solicitar mudança de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(
          message:
              "Erro ao solicitar mudança de foto de perfil, tente novamente mais tarde");
    }
  }

  @override
  Future<void> updatePhotoRequest(int id, String status) async {
    try {
      await DioClient()
          .patch("/student/photo/request/$id", data: {"status": status});
    } on DioError catch (e, s) {
      log("Erro no servidor ao atualizar status da mudança de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, s) {
      log("Erro ao atualizar status da mudança de foto de perfil: ",
          error: e, stackTrace: s);
      throw RepositoryException(
          message:
              "Erro ao atualizar solicitação de troca da foto de perfil, tente novamente mais tarde");
    }
  }
}
