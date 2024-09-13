
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository.dart';

class CaeRepositoryImpl implements CaeRepository {
  @override
  Future<void> deleteAllStudents() async {
    try {
      await DioClient().delete('/students-delete');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os alunos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os alunos');
    }
  }
  
}