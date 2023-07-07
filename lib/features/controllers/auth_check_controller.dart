import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckController extends ChangeNotifier {
  bool check = false;
  bool isLoading = true;
  bool admin = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> verify() async {
    final sp = await SharedPreferences.getInstance();
    final matricula = sp.getString('matricula');
    final user = sp.getString('username');

    if (matricula != null) {
      check = true;
    }

    if (user != null) {
      check = true;
      admin = true;
    }

    loading();
  }
}
