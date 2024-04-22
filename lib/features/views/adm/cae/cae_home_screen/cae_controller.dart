import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/utils/links.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaeController extends ChangeNotifier {
  /// Função para sair da conta
  onLogoutTap() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<void> loadLink() async {
    await Links.i.loadLink();
  }
}
