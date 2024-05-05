import 'dart:convert';

class TablesModel {
  final int id;
  String description;

  TablesModel({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  factory TablesModel.fromMap(Map<String, dynamic> map) {
    return TablesModel(
      id: map['id'] ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TablesModel.fromJson(String source) => TablesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
