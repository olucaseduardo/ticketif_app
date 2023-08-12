
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';

class SpecialNavigation {
  late final GlobalKey<NavigatorState> _navigatorKey;

  SpecialNavigation._();

  static SpecialNavigation? _instance;

  static SpecialNavigation get i {
    _instance ??= SpecialNavigation._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  void isNotCae() {
    Navigator.pushNamedAndRemoveUntil(
                  _navigatorKey.currentContext!,
                  AppRouter.homeRoute,
                  (route) => false,
                );
  }

  void isCae() {
    Navigator.pop(_navigatorKey.currentState!.context);
  }
}