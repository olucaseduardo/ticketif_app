import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CampusConfig {
  final List<String> links;
  final String version;

  CampusConfig({required this.links, required this.version});

  factory CampusConfig.fromMap(Map<String, dynamic> map) {
    return CampusConfig(
      links: List<String>.from(map["links"]),
      version: map["version"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"links": links, "version": version};
  }
}

class Links extends ChangeNotifier {
  // Links de acesso organizados por prioridade
  final Map<String, CampusConfig> _campusLinks = {
    "Caxias": CampusConfig(
      links: ['http://10.9.12.10:8088', 'https://ticket-caxias.ifma.edu.br'],
      version: "v1",
    ),
    "Timon": CampusConfig(
      links: ['https://timon.ifma.edu.br/sistemas/ticket-api'],
      version: "v1",
    ),
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
    List<String>? links = _campusLinks[campus]?.links;
    if (links != null) {
      String? validLink = await _getValidLink(links);
      String version = _campusLinks[campus]!.version;

      if (validLink != null && version.isNotEmpty) {
        _campusLink =
            validLink.endsWith('/') || version.startsWith('/')
                ? "$validLink$version"
                : "$validLink/$version";
      } else {
        _campusLink = validLink ?? '';
      }
      log(_campusLink);

      final sp = await SharedPreferences.getInstance();
      sp.setString('campus', campus);
      sp.setString('link', _campusLink);
      notifyListeners();
    } else {
      _campusLink = '';
    }
  }

  Future<void> selectLink(String campus) async {
    List<String>? links = _campusLinks[campus]?.links;
    if (links != null) {
      _campusLink = await _getValidLink(links) ?? '';
      final sp = await SharedPreferences.getInstance();
      sp.setString('campus', campus);
      notifyListeners();
    }
  }

  String get selectedLink => _campusLink;

  Future<String?> _getValidLink(List<String> links) async {
    for (String link in links) {
      if (await _isLinkActive(link)) {
        return link;
      }
    }
    return null;
  }

  Future<bool> _isLinkActive(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
