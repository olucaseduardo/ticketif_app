import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/core/utils/links.dart';

class AuthCheckController extends ChangeNotifier {
  bool check = false;
  bool isLoading = true;
  bool cae = false;
  bool restaurant = false;

  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> verify() async {
    final sp = await SharedPreferences.getInstance();
    final matricula = sp.getString('matricula');
    final adminTypeId = sp.getInt('admin_type_id');
    final campus = sp.getString("campus");
    if (campus == null) {
      loading();
      return;
    }

    if (matricula != null) {
      check = true;
    }
    if (adminTypeId != null) {
      if (adminTypeId == 1) {
        cae = true;
      } else if (adminTypeId == 2) {
        restaurant = true;
      }
      check = true;
    }
    loading();
  }
}
