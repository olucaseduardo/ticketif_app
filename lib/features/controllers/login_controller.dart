import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/services/dio_client.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';

class LoginController extends ChangeNotifier {
  Future<void> onLoginTap(String mat, String password) async {
    try {
      await DioClient().unauth().post('/auth', data: {
        'email': mat,
        'password': password,
      });
      navigatorKey.currentState!.pushNamed(AppRouter.homeRoute);
    } catch (e) {
      log('falha', error: e);
    }
  }
}
