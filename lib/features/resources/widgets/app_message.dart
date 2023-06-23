import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class AppMessage {
  static void showMessage(String text) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.green500,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showError(String text) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showInfo(String text) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.yellow,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
