import 'dart:convert';

class AuthModel {
  final String matricula;
  
  AuthModel({
    required this.matricula,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula': matricula,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      matricula: map['matricula'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}