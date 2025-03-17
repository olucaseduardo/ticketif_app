
import 'dart:convert';

class SystemConfig {
  int id;
  String key;
  String value;
  String description;
  bool isActive;
  DateTime updatedAt;

  SystemConfig({
    required this.id,
    required this.key,
    required this.value,
    required this.description,
    required this.isActive,
    required this.updatedAt
  });

  factory SystemConfig.fromMap(Map<String,dynamic> map) {
    return SystemConfig(
      id: map["id"] as int,
      key: map["key"] as String,
      value: map["value"] as String,
      description: map["description"] as String,
      isActive: map["is_active"] as bool,
      updatedAt: DateTime.parse(map["updated_at"])
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "id":id,
      "key":key,
      "value":value,
      "description":description,
      "is_active":isActive,
      "updated_at":updatedAt
    };
  }

  String toJson() => json.encode(toMap());

  factory SystemConfig.fromJson(String source) => SystemConfig.fromMap(jsonDecode(source) as Map<String,dynamic>);

  @override
  toString() {
    return 'SystemConfig(id: $id, key: $key, value: $value, description: $description, is_active: $isActive, updated_at: $updatedAt)';
  }
}