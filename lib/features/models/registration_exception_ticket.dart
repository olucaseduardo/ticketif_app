
import 'dart:convert';

class RegistrationExceptionTicket {
  int id;
  String value;

  RegistrationExceptionTicket({
    required this.id,
    required this.value
  });

  factory RegistrationExceptionTicket.fromMap(Map<String,dynamic> map) {
    return RegistrationExceptionTicket(
        id: map["id"],
        value: map["value"]);
  }

  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "value": value
    };
  }

  String toJson() => json.encode(toMap());

  factory RegistrationExceptionTicket.fromJson(String source) => RegistrationExceptionTicket.fromMap(jsonDecode(source) as Map<String,dynamic>);

  @override
  toString() {
    return 'SystemConfig(id: $id, value: $value)';
  }
}