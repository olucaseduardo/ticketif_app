import 'dart:convert';

class AuthModel {
  final String matricula;
  final String user;
  final int loginTypeId;

  AuthModel({
    required this.matricula,
    required this.user,
    required this.loginTypeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula': matricula,
      'username': user,
      'login_type_id': loginTypeId,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      matricula: map['registration'] ?? '',
      user: map['username'] ?? '',
      loginTypeId: map['admin_type_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
