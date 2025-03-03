import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudentAuthorization {
  final String matricula;
  final int idStudent;
  final String text;
  final List<int> ticketsIds;
  int mealId;
  String meal;
  String days;

  StudentAuthorization({
    required this.ticketsIds,
    required this.matricula,
    required this.idStudent,
    required this.text,
    required this.mealId,
    required this.meal,
    required this.days,
  });

  @override
  String toString() {
    return 'StudentAuthorization(matricula: $matricula, idStudent: $idStudent, justification: $text, meal_id: $mealId, meal: $meal, days: $days)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula': matricula,
      'idStudent': idStudent,
      'text': text,
      'meal_id': mealId,
      'meal': meal,
      'days': days,
    };
  }

  factory StudentAuthorization.fromMap(Map<String, dynamic> map) {
    return StudentAuthorization(
      ticketsIds: [],
      matricula: map['matricula'] as String,
      idStudent: map['idStudent'] as int,
      text: map['text'] as String,
      mealId: map['meal_id'] as int,
      meal: map['meal'] as String,
      days: map['days'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentAuthorization.fromJson(String source) =>
      StudentAuthorization.fromMap(json.decode(source) as Map<String, dynamic>);
}
