import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';

class AppMessage {
  late final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  AppMessage._();

  static AppMessage? _instance;

  static AppMessage get i {
    _instance ??= AppMessage._();
    return _instance!;
  }

  set scaffoldMessagerKey(GlobalKey<ScaffoldMessengerState> key) =>
      _scaffoldMessengerKey = key;

  void showMessage(String text) {
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void showError(String text) {
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void showInfo(String text) {
    _scaffoldMessengerKey.currentState!.showSnackBar(
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
}
