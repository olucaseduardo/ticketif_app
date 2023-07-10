import 'dart:convert';

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

  factory QrResult.fromJson(String source) => QrResult.fromMap(json.decode(source) as Map<String, dynamic>);

  

  @override
  String toString() {
    return 'QrResult(id: $id, student: $student, studentName: $studentName, status: $status, date: $date, dateStr: $dateStr, meal: $meal)';
  }
}
