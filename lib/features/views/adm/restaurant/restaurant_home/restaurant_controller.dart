import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/utils/links.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController extends ChangeNotifier {
   /// Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<void> loadLink() async {
    await Links.i.loadLink();
  }
}
