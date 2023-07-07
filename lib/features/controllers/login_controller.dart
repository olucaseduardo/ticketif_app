import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/unauthorized_exception.dart';
import 'package:project_ifma_ticket/features/repositories/auth/auth_api_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  void loading() {
    isLoading = !isLoading;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> onLoginTap(String matricula, String password) async {
    error = false;
    notifyListeners();
    try {
      final authModel =
          await AuthApiRepositoryImpl().login(matricula, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('matricula', authModel.matricula);

      log('Sucesso');
      loading();
    } on UnauthorizedException catch (e, s) {
      error = true;
      notifyListeners();
      loading();
      log('Login ou senha inválidos', error: e, stackTrace: s);
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao realizar login', error: e, stackTrace: s);
      loading();
    }
  }

  Future<void> onLoginAdmTap(String username, String password) async {
    error = false;
    notifyListeners();
    try {
      final authModel =
          await AuthApiRepositoryImpl().loginADM(username, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('username', authModel.user);

      log('Sucesso');
      loading();
    } on UnauthorizedException catch (e, s) {
      error = true;
      notifyListeners();
      loading();
      log('Login ou senha inválidos', error: e, stackTrace: s);
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao realizar login', error: e, stackTrace: s);
      loading();
    }
  }
}
