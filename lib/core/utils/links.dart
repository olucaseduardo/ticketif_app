
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Links extends ChangeNotifier {
  // Links de acesso
  final Map<String, String> _campusLinks = {
    "Caxias": 'https://ticket-caxias.ifma.edu.br/v1',
    // "Caxias": 'http://192.168.10.68:8000/v1',
    "Timon": 'https://timon.ifma.edu.br/sistemas/ticket-api',
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
    var campus = sp.getString('campus') ?? '';
    _campusLink = _campusLinks[campus] ?? '';
  }

  Future<void> selectLink(String campus) async {
    _campusLink = _campusLinks[campus] as String;
    final sp = await SharedPreferences.getInstance();
    sp.setString('campus', campus);
    sp.setString('link', _campusLink);
    notifyListeners();
  }

  String get selectedLink => _campusLink;
}
