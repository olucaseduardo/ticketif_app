import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/dto/patch_system_config_dto.dart';
import 'package:ticket_ifma/features/models/class.dart';
import 'package:ticket_ifma/features/models/registration_exception_ticket.dart';
import 'package:ticket_ifma/features/models/system_config.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository.dart';

class CaeRepositoryImpl implements CaeRepository {
  @override
  Future<void> deleteAllStudents() async {
    try {
      await DioClient().delete('/student/');
    } on DioException catch (e, s) {
      log('Erro ao deletar todos os alunos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os alunos');
    }
  }

  @override
  Future<void> addNewClass(String newClass, String course) async {
    try {
      await DioClient().post(
        '/class/', data: {"registration": newClass, "course": course});
    } on DioException catch (e, s) {
      log('Erro ao inserir nova turma', error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<void> deleteClass(int id) async {
    try {
      await DioClient().delete(
        '/class/$id',
      );
    } on DioException catch (e, s) {
      log('Erro ao deletar uma turma', error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<List<Class>> findAllClass() async {
    try {
      final response = await DioClient().get('/class');
      final classes = List<Class>.from(
          response.data["data"]["classes"].map((item) => Class.fromMap(item)));
      return classes;
    } on DioException catch (e, s) {
      log('Erro ao buscar as turmas', error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<void> createRegistrationExceptionTicket(String value) async {
    try {
      await DioClient().post("/ticket/exception/", data: {"value": value});
    } on DioException catch (e, s) {
      log('Erro ao buscar as turmas',
          error: e.response?.data["message"], stackTrace: s);
      throw RepositoryException(message: e.response?.data["message"]);
    }
  }

  @override
  Future<void> deleteRegistrationExceptionTicket(int id) async {
    try {
      await DioClient().delete("/ticket/exception/$id");
    } on DioException catch (e, s) {
      log('Erro ao buscar as turmas', error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<List<RegistrationExceptionTicket>>
      findAllRegistrationExceptionTicket() async {
    try {
      final response = await DioClient().get("/ticket/exception/");
      return List<RegistrationExceptionTicket>.from(response.data["data"]
              ["exceptions"]
          .map((e) => RegistrationExceptionTicket.fromMap(e)));
    } on DioException catch (e, s) {
      log('Erro ao buscar as matriculas com exceção de horário',
          error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<List<SystemConfig>> findAllSystemConfig() async {
    try {
      final response = await DioClient().get("/system/config");
      return List<SystemConfig>.from(response.data["data"]["configurations"]
          .map((e) => SystemConfig.fromMap(e)));
    } on DioException catch (e, s) {
      log('Erro ao buscar as configurações do sistema',
          error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }

  @override
  Future<void> updateSystemConfig(int id, PatchSystemConfigDTO patch) async {
    try {
      await DioClient().patch("/system/config/$id", data: patch.toMap());
    } on DioException catch (e, s) {
      log('Erro ao atualizar as configurações do sistema',
          error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message ?? "");
    }
  }
}
