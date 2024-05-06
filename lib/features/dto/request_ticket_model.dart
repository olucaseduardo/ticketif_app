import 'dart:convert';

class RequestTicketModel {
  final int studentId;
  final int weekId;
  final int mealId;
  final int statusId;
  final int isCae;
  final int justificationId;
  final int isPermanent;
  final String solicitationDay;
  final String useDay;
  final String useDayDate;
  final String paymentDay;
  final String text;
  
  RequestTicketModel({
    required this.studentId,
    required this.weekId,
    required this.mealId,
    required this.statusId,
    this.isCae = 0,
    required this.justificationId,
    required this.isPermanent,
    required this.solicitationDay,
    required this.useDay,
    required this.useDayDate,
    required this.paymentDay,
    required this.text, 
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'week_id': weekId,
      'meal_id': mealId,
      'status_id': statusId,
      'is_cae': isCae,
      'justification_id': justificationId,
      'solicitation_day': solicitationDay,
      'use_day': useDay,
      'use_day_date': useDayDate,
      'payment_day': paymentDay,
      'text': text,
      'is_permanent': isPermanent,
    };
  }

  factory RequestTicketModel.fromMap(Map<String, dynamic> map) {
    return RequestTicketModel(
      studentId: map['studentId'] as int,
      weekId: map['weekId'] as int,
      mealId: map['mealId'] as int,
      statusId: map['statusId'] as int,
      justificationId: map['justificationId'] as int,
      isPermanent: map['isPermanent'] as int,
      solicitationDay: map['solicitationDay'] as String,
      useDay: map['useDay'] as String,
      useDayDate: map['useDayDate'] as String,
      paymentDay: map['paymentDay'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTicketModel.fromJson(String source) => RequestTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
