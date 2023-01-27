import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';

class LoginController extends ChangeNotifier{
  onLoginTap() {
    navigatorKey.currentState!.pushNamed(AppRouter.homeRoute);
  }
}
