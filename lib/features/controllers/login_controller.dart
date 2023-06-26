import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/unauthorized_exception.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/auth/auth_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> onLoginTap(String matricula, String password) async {
    try {
      // loading();
      final authModel =
          await AuthApiRepositoryImpl().login(matricula, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('matricula', authModel.matricula);

      log('Sucesso');
      loading();
    } on UnauthorizedException catch (e, s) {
      loading();
      log('Login ou senha inválidos', error: e, stackTrace: s);
    } catch (e, s) {
      loading();
      log('Erro ao realizar login', error: e, stackTrace: s);
    }
  }
}
