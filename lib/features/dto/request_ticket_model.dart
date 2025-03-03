import 'dart:convert';

class RequestTicketModel {
  final int studentId;
  final int mealId;
  final int justificationId;
  final String description;
  
  RequestTicketModel({
    required this.studentId,
    required this.mealId,
    required this.justificationId,
    required this.description,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'meal_id': mealId,
      'justification_id': justificationId,
      'description': description,
    };
  }

  factory RequestTicketModel.fromMap(Map<String, dynamic> map) {
    return RequestTicketModel(
      studentId: map['studentId'] as int,
      mealId: map['mealId'] as int,
      justificationId: map['justificationId'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTicketModel.fromJson(String source) => RequestTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
