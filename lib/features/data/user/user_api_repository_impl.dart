import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/services/dio_client.dart';
import 'package:project_ifma_ticket/features/models/user.dart';

import './user_api_repository.dart';

class UserApiRepositoryImpl implements UserApiRepository {
  
  @override
  Future<User> loadUser() async {
     try {
      final result = await DioClient().auth().get("/me");

      return User.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }

}