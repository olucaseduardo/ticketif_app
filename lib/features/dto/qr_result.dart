import 'dart:convert';

import 'package:ticket_ifma/core/exceptions/qr_code_exception.dart';
import 'package:ticket_ifma/core/utils/encrypt_util.dart';

class QrResult {
  final int id;
  final String student;
  final String studentName;
  final String status;
  final String date;
  final String dateStr;
  final String meal;

  QrResult({
    required this.id,
    required this.student,
    required this.studentName,
    required this.status,
    required this.date,
    required this.dateStr,
    required this.meal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student': student,
      'studentName': studentName,
      'status': status,
      'date': date,
      'dateStr': dateStr,
      'meal': meal,
    };
  }

  factory QrResult.fromMap(Map<String, dynamic> map) {
    return QrResult(
      id: map['id'] as int,
      student: map['student'] as String,
      studentName: map['student_name'] as String,
      status: map['status'] as String,
      date: map['date'] as String,
      dateStr: map['date_str'] as String,
      meal: map['meal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrResult.fromJson(String source) {
    try {
      final data = EncryptUtil().decrypt(source);
      return QrResult.fromMap(json.decode(data) as Map<String, dynamic>);
    } catch (e) {
      throw QrCodeException(message: "Erro ao obter dados do ticket");
    }
  }

  @override
  String toString() {
    return 'QrResult(id: $id, student: $student, studentName: $studentName, status: $status, date: $date, dateStr: $dateStr, meal: $meal)';
  }
}
