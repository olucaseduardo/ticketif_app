import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudentAuthorization {
  final String matricula;
  final int idStudent;
  final String text;
  final List<int> ticketsIds;
  final List<String> listDays;
  int mealId;
  String meal;

  StudentAuthorization({
    required this.ticketsIds,
    required this.matricula,
    required this.idStudent,
    required this.text,
    required this.mealId,
    required this.meal,
    required this.listDays
  });

  @override
  String toString() {
    return 'StudentAuthorization(matricula: $matricula, idStudent: $idStudent, justification: $text, meal_id: $mealId, meal: $meal, days: ${getDays()}, tickets_id:$ticketsIds)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula': matricula,
      'idStudent': idStudent,
      'text': text,
      'meal_id': mealId,
      'meal': meal,
    };
  }

  factory StudentAuthorization.fromMap(Map<String, dynamic> map) {
    return StudentAuthorization(
      listDays: [],
      ticketsIds: [],
      matricula: map['matricula'] as String,
      idStudent: map['idStudent'] as int,
      text: map['text'] as String,
      mealId: map['meal_id'] as int,
      meal: map['meal'] as String,
    );
  }

  String getDays() {
    return "(${listDays.map((e) => e.substring(0,3)).join(", ")})";
  }

  String toJson() => json.encode(toMap());

  factory StudentAuthorization.fromJson(String source) =>
      StudentAuthorization.fromMap(json.decode(source) as Map<String, dynamic>);
}
