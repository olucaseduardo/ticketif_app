import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_api_repository.dart';

class UserApiRepositoryImpl implements UserApiRepository {
  @override
  Future<User> loadUser() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final matricula = sp.getString('matricula');
      final result = await DioClient().get("/student/$matricula");
      return User.fromMap(result.data["data"]["student"]);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }

  @override
  Future<List<User>> findAllStudents() async {
    try {
      final result = await DioClient().get("/student/");
      return result.data["data"]["students"].map<User>((u) => User.fromMap(u)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar estudantes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar estudantes');
    }
  }
}
