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
      authorized: map['status_id'] as int,
      student: map['student_registration'] as String,
      studentName: map['student_name'] as String,
      justification: map['justification_description'] as String,
      meal: map['meal_description'] as String,
      type: map['student_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Authorization.fromJson(String source) =>
      Authorization.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Authorization(id: $id, studentId: $studentId, mealId: $mealId, weekId: $weekId, justificationId: $justificationId, authorized: $authorized, student: $student, studentName: $studentName, justification: $justification, meal: $meal, type: $type)';
  }

  String day() {
    if (weekId == 1) {
      return 'Seg';
    } else if (weekId == 2) {
      return 'Ter';
    } else if (weekId == 3) {
      return 'Qua';
    } else if (weekId == 4) {
      return 'Qui';
    } else if (weekId == 5) {
      return 'Sex';
    } else if (weekId == 6) {
      return 'Sab';
    } else if (weekId == 7) {
      return 'Dom';
    }
    return '';
  }
}
