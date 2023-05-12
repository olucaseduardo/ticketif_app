import 'dart:convert';

class User {
  final int id;
  final String name;
  final String matricula;
  final String password;
  final List<String> days;
  final int isPermanent;

  User({
    required this.id,
    required this.name,
    required this.matricula,
    required this.password,
    required this.days,
    required this.isPermanent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': matricula,
      'password': password,
      'days': days,
      'isPermanent': isPermanent,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      matricula: map['email'] ?? '',
      password: map['password'] ?? '',
      days: List<String>.from(map['days'] ?? []),
      isPermanent: map['isPermanent'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
