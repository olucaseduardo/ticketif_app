import 'dart:convert';

class RequestPermanent {
  final int studentId;
  final List<int> weekId;
  final int mealId;
  final int justificationId;
  final String description;

  RequestPermanent({
    required this.studentId,
    required this.weekId,
    required this.mealId,
    required this.justificationId,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'week_id': weekId,
      'meal_id': mealId,
      'justification_id': justificationId,
      'description': description,
    };
  }

  factory RequestPermanent.fromMap(Map<String, dynamic> map) {
    return RequestPermanent(
      studentId: map['student_id'] ?? 0,
      weekId: map['week_id'] ?? "",
      mealId: map['meal_id'] ?? "",
      justificationId: map['justification_id'] ?? 0,
      description: map['description'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestPermanent.fromJson(String source) =>
      RequestPermanent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestPermanent(studentId: $studentId, weekId: $weekId, mealId: $mealId, justificationId: $justificationId, description: $description)';
  }
}
