import 'package:flutter/material.dart';

class Links extends ChangeNotifier {
  // Links de acesso
  final Map<String, String> _campusLinks = {
    "Caxias": 'https://77a7-45-231-15-191.ngrok-free.app',
    "Timon": 'https://0c3f-45-231-15-191.ngrok-free.app',
  };

  late String _campusLink;

  Links._();

  static Links? _instance;

  static Links get i {
    _instance ??= Links._();
    return _instance!;
  }
  
  Future<void> selectLink(String campus) async {
    _campusLink = _campusLinks[campus] as String;
    notifyListeners();
  }

  String get selectedLink => _campusLink;
}
