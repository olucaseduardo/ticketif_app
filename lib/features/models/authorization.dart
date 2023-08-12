// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Authorization {
  final int id;
  final int studentId;
  final int mealId;
  final int weekId;
  final int justificationId;
  final int authorized;
  final String student;
  final String studentName;
  final String justification;
  final String meal;
  final String type;
  
  Authorization({
    required this.id,
    required this.studentId,
    required this.mealId,
    required this.weekId,
    required this.justificationId,
    required this.authorized,
    required this.student,
    required this.studentName,
    required this.justification,
    required this.meal,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'meal_id': mealId,
      'week_id': weekId,
      'justification_id': justificationId,
      'authorized': authorized,
      'student': student,
      'student_name': studentName,
      'justification_description': justification,
      'meal_description': meal,
      'type': type,
    };
  }

  factory Authorization.fromMap(Map<String, dynamic> map) {
    return Authorization(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      mealId: map['meal_id'] as int,
      weekId: map['week_id'] as int,
      justificationId: map['justification_id'] as int,
      authorized: map['authorized'] as int,
      student: map['student'] as String,
      studentName: map['student_name'] as String,
      justification: map['justification_description'] as String,
      meal: map['meal_description'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Authorization.fromJson(String source) => Authorization.fromMap(json.decode(source) as Map<String, dynamic>);
}
