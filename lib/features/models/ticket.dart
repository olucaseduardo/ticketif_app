// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Meal { breakfast, lunch, dinner, supper }

enum Status { analysis, payment, cancelled, refused, approved, used }

class Ticket {
  final int id;
  final int idStudent;
  final String date;
  final String student;
  final String meal;
  final String status;
  final String reason;
  final String text;

  Ticket(this.id, this.idStudent, this.date, this.student, this.meal,
      this.status, this.reason, this.text);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idStudent': idStudent,
      'date': date,
      'student': student,
      'meal': meal,
      'status': status,
      'reason': reason,
      'text': text,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      map['id'] ?? 0,
      map['idStudent'] ?? 0,
      map['date'] ?? '',
      map['student'] ?? '',
      map['meal'] ?? '',
      map['status'] ?? '',
      map['reason'] ?? '',
      map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source) as Map<String, dynamic>);
}
