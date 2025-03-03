import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository.dart';

class CaeRepositoryImpl implements CaeRepository {
  @override
  Future<void> deleteAllStudents() async {
    try {
      await DioClient().delete('/student/');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os alunos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os alunos');
    }
  }

  @override
  Future<void> addNewClass(String newClass, String course) async {
    try {
      await DioClient().post(
        '/class/',
        data:
        {
          "registration": newClass,
          "course": course
        }
      );
    } on DioError catch (e, s) {
      log('Erro ao inserir nova turma', error: e.message, stackTrace: s);
      throw RepositoryException(message: e.message);
    }
  }
}
