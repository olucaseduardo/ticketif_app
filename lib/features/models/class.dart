
import 'dart:convert';

class Class {
  final int id;
  final String registration;
  final String course;

  Class({
    required this.id,
    required this.registration,
    required this.course,
  });

  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "registration": registration,
      "course": course
    };
  }

  factory Class.fromMap(Map<String,dynamic> map) {
    return Class(
        id: map["id"] as int,
        registration: map["registration"] as String,
        course: map["course"] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory Class.fromJson(String source) => Class.fromMap(jsonDecode(source) as Map<String,dynamic>);

  @override
  toString() {
    return 'Class(id: $id, registration: $registration, course: $course)';
  }
}