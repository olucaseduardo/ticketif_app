import 'dart:convert';

class User {
  final int id;
  final String name;
  final String matricula;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.matricula,
    required this.type,
  });

  String get username {
    List<String> words = name.trim().split(RegExp(r'\s+'));
    String firstName = words[0];
    String lastName = words[words.length - 1];
    String middleInitials = '';

    for (int i = 1; i < words.length - 1; i++) {
      String part = words[i];

      if (part.isNotEmpty) {
        part[0] == part[0].toLowerCase()
            ? middleInitials += '$part '
            : middleInitials += '${part[0]}. ';
      }
    }

    if (middleInitials == '') {
      return '$firstName $lastName';
    } else {
      return '$firstName $middleInitials$lastName';
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'matricula': matricula,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      matricula: map['registration'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
