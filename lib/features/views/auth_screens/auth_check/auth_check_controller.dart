import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckController extends ChangeNotifier {
  bool check = false;
  bool isLoading = true;
  bool cae = false;
  bool restaurant = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
    log('loading $isLoading');
  }

  Future<void> verify() async {
    final sp = await SharedPreferences.getInstance();
    final matricula = sp.getString('matricula');
    final user = sp.getString('username');

    log('loading $isLoading');

    if (matricula != null) {
      check = true;
    }

    if (user != null) {
      if (user == 'CAE') {
        check = true;
        cae = true;
      } else {
        check = true;
        restaurant = true;
      }
    }

    loading();
  }
}
