import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/exceptions/unauthorized_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/models/auth_model.dart';
import './auth_api_repository.dart';

class AuthApiRepositoryImpl implements AuthApiRepository {
  @override
  Future<AuthModel> login(String matricula, String password) async {
    try {
      await DioClient().post("/auth/student/login",
          data: {"registration": matricula, "password": password
      });
      return AuthModel(matricula: matricula, user: '', loginTypeId: 0);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        log('Falha na autenticação!', error: e.message);
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 401) {
        log('Permissão negada', error: e.message);
        throw UnauthorizedException();
      }
      log('Erro ao realizar login', error: e.message);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<AuthModel> loginADM(String username, String password) async {
    try {
      final response =
          await DioClient().post('/auth/administrator/login', data: {
        'username': username,
        'password': password,
      });
      final authModel = AuthModel.fromMap(response.data["data"]);
      return authModel;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        log('Falha na autenticação!', error: e.message);
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 401) {
        log('Permissão negada', error: e.message);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e.message);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
