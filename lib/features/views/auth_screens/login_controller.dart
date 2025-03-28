import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/unauthorized_exception.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:ticket_ifma/features/repositories/auth/auth_api_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  List<String> campus = ["Caxias", "Timon"];
  String campusSelect = "";
  PackageInfo? packageInfo;

  /// Função responsável por selecionar o link de acesso com base no respectivo campus
  Future<void> selectCampus(String campus) async {
    campusSelect = campus;
    await Links.i.selectLink(campusSelect);
  }

  Future<void> loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> onLoginTap(String matricula, String password) async {
    error = false;
    notifyListeners();
    try {
      await Links.i.loadLink();
      final authModel = await AuthApiRepositoryImpl().login(
        matricula,
        password,
      );

      final sp = await SharedPreferences.getInstance();
      sp.setString('matricula', authModel.matricula);
      campusSelect = "";
      loading();
    } on UnauthorizedException catch (e, s) {
      error = true;
      campusSelect = "";
      notifyListeners();
      loading();
      log('Login ou senha inválidos', error: e, stackTrace: s);
    } catch (e, s) {
      error = true;
      campusSelect = "";
      notifyListeners();
      log('Erro ao realizar login', error: e, stackTrace: s);
      loading();
    }
  }

  Future<void> onLoginAdmTap(String username, String password) async {
    error = false;
    notifyListeners();

    try {
      await Links.i.loadLink();
      final authModel = await AuthApiRepositoryImpl().loginADM(
        username,
        password,
      );

      final sp = await SharedPreferences.getInstance();
      sp.setInt('admin_type_id', authModel.loginTypeId);

      campusSelect = "";
      loading();
    } on UnauthorizedException catch (e) {
      error = true;
      campusSelect = "";
      notifyListeners();
      loading();
      log('Login ou senha inválidos', error: e);
    } catch (e) {
      error = true;
      campusSelect = "";
      notifyListeners();
      log('Erro ao realizar login', error: e);
      loading();
    }
  }
}
