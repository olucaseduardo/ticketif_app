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
      final result = await DioClient().post('/login', data: {
        'matricula': matricula,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 404) {
        log('Falha na autenticação!', error: e, stackTrace: s);
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 401) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<AuthModel> loginADM(String username, String password) async {
    try {
      final result = await DioClient().post('/login-adm', data: {
        'username': username,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 404) {
        log('Falha na autenticação!', error: e, stackTrace: s);
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 401) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
