import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Links extends ChangeNotifier {
  // Links de acesso
  final Map<String, String> _campusLinks = {
    "Caxias": 'https://cbb0-201-20-127-177.ngrok-free.app',
    "Timon": 'https://0c3f-45-231-15-191.ngrok-free.app',
  };

  late String _campusLink;

  Links._();

  static Links? _instance;

  static Links get i {
    _instance ??= Links._();
    return _instance!;
  }

  Future<void> loadLink() async {
    final sp = await SharedPreferences.getInstance();
    _campusLink = sp.getString('link') ?? '';
  }

  Future<void> selectLink(String campus) async {
    _campusLink = _campusLinks[campus] as String;
    final sp = await SharedPreferences.getInstance();
    sp.setString('link', _campusLink);
    notifyListeners();
  }

  String get selectedLink => _campusLink;
}
