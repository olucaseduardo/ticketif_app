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
          style: const TextStyle(color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // static void showMessage(String message) {
  //   showTopSnackBar(
      
  //     Overlay.of(navigatorKey.currentContext!),
  //     CustomSnackBar.success(message: message, backgroundColor: AppColors.green500,),
  //   );
  // }

  // static void showInfo(String message) {
  //   showTopSnackBar(
  //     Overlay.of(navigatorKey.currentContext!),
  //     CustomSnackBar.info(message: message, backgroundColor: AppColors.yellow),
  //   );
  // }

  // static void showError(String message) {
  //   showTopSnackBar(
  //     Overlay.of(navigatorKey.currentContext!),
  //     CustomSnackBar.error(message: message, backgroundColor: AppColors.red),
  //   );
  // }
}
