import 'dart:convert';
import 'package:ticket_ifma/core/utils/path_image.dart' as path_image;

class PermanentModel {
  final int id;
  final int studentId;
  final int mealId;
  final int weekId;
  final int justificationId;
  final int authorized;
  final String justificationDescription;
  final String mealDescription;
  final String weekDescription;

  PermanentModel({
    required this.id,
    required this.studentId,
    required this.mealId,
    required this.weekId,
    required this.justificationId,
    required this.authorized,
    required this.justificationDescription,
    required this.mealDescription,
    required this.weekDescription,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'meal_id': mealId,
      'week_id': weekId,
      'justification_id': justificationId,
      'authorized': authorized,
      'justification_description': justificationDescription,
      'meal_description': mealDescription,
      'week_description': weekDescription,
    };
  }

  factory PermanentModel.fromMap(Map<String, dynamic> map) {
    return PermanentModel(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      mealId: map['meal_id'] as int,
      weekId: map['week_id'] as int,
      justificationId: map['justification_id'] as int,
      authorized: map['status_id'] as int,
      justificationDescription: map['justification_description'] as String,
      mealDescription: map['meal_description'] as String,
      weekDescription: map['week_description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermanentModel.fromJson(String source) => PermanentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String statusImage() {
    if (authorized == 1) {
      return path_image.analysis;
    } else if (authorized == 4) {
      return path_image.authorizedUse;
    } else if (authorized == 2 || authorized == 3 || authorized == 7) {
      return path_image.canceled;
    }

    return '';
  }
}
