import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController extends ChangeNotifier {
   /// Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
