import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckController extends ChangeNotifier {
  bool check = false;
  bool isLoading = true;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> verify() async {
    final sp = await SharedPreferences.getInstance();
    final matricula = sp.getString('matricula');

    if (matricula != null) {
      check = true;
    }

    loading();
  }
}
