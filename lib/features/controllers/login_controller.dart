import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/unauthorized_exception.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/auth/auth_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  Future<void> onLoginTap(String matricula, String password) async {
    try {
      final authModel = await AuthApiRepositoryImpl().login(matricula, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('matricula', authModel.matricula);

      navigatorKey.currentState!.pushNamed(AppRouter.homeRoute);
      log('Sucesso');
    } on UnauthorizedException catch (e, s) {
      log('Login ou senha inválidos', error: e, stackTrace: s);

    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
    }
  }
}
