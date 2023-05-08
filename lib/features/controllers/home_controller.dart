import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/user/user_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/arguments.dart';

class HomeController extends ChangeNotifier {
  User? user;

  onRequestTicketTap() {
    Navigator.pushNamed(
        navigatorKey.currentContext!, AppRouter.requestTicketRoute);
  }

  onLogoutTap() {}
  onTicketsTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Seus tickets'));
  }

  onAnalysisTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Tickets em análise'));
  }

  onHistoricTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Histórico'));
  }

  onQrCodeTap() {
    Navigator.pushNamed(
      navigatorKey.currentContext!,
      AppRouter.qrRoute,
    );
  }

  Future<void> loadUser() async {
    try {
      final userData = await UserApiRepositoryImpl().loadUser();

      user = userData;

      notifyListeners();
      // return User.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
