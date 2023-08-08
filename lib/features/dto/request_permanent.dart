import 'dart:convert';

class RequestPermanent {
  final int studentId;
  final int weekId;
  final int mealId;
  final int justificationId;
  final String text;
  final String useDay;
  final String useDayDate;
  final int authorized;
  final int statusId;

  RequestPermanent({
    required this.studentId,
    required this.weekId,
    required this.mealId,
    required this.justificationId,
    required this.text,
    required this.useDay,
    required this.useDayDate,
    required this.authorized,
    required this.statusId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'week_id': weekId,
      'meal_id': mealId,
      'justification_id': justificationId,
      'text': text,
      'use_day': useDay,
      'use_day_date': useDayDate,
      'authorized': authorized,
      'status_id': statusId,
    };
  }

  factory RequestPermanent.fromMap(Map<String, dynamic> map) {
    return RequestPermanent(
      studentId: map['student_id'] ?? 0,
      weekId: map['week_id'] ?? "",
      mealId: map['meal_id'] ?? "",
      justificationId: map['justification_id'] ?? 0,
      text: map['text'] ?? "",
      useDay: map['use_day'] ?? "",
      useDayDate: map['use_day_date'] ?? "",
      authorized: map['authorized'] ?? 0,
      statusId: map['status_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestPermanent.fromJson(String source) =>
      RequestPermanent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestPermanent(studentId: $studentId, weekId: $weekId, mealId: $mealId, justificationId: $justificationId, text: $text, useDay: $useDay, useDayDate: $useDayDate, authorized: $authorized)';
  }
}
