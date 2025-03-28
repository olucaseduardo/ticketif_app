// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ticket_ifma/core/utils/encrypt_util.dart';
import 'package:ticket_ifma/core/utils/path_image.dart' as path_image;

class Ticket {
  final int id;
  final int idStudent;
  int idStatus;
  final int idMeal;
  final String useDayDate;
  final String useDay;
  final String student;
  final String studentName;
  final String type;
  final String meal;
  String status;
  final String justification;
  final String text;
  final int isPermanent;
  final String solicitationDay;

  Ticket(
    this.id,
    this.idStudent,
    this.idStatus,
    this.idMeal,
    this.useDayDate,
    this.useDay,
    this.student,
    this.studentName,
    this.type,
    this.meal,
    this.status,
    this.justification,
    this.text,
    this.isPermanent,
    this.solicitationDay,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': idStudent,
      'status_id': idStatus,
      'meal_id': idMeal,
      'week_description': useDay,
      'created_at': useDayDate,
      'student_registration': student,
      'student_name': studentName,
      'student_type': type,
      'meal_description': meal,
      'status_description': status,
      'justification_description': justification,
      'description': text,
      'permanent_id': isPermanent,
      'solicitation_day': solicitationDay
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      map['id'] ?? 0,
      map['student_id'] ?? 0,
      map['status_id'] ?? 0,
      map['meal_id'] ?? 0,
      map['created_at'] ?? '',
      map['week_description'] ?? '',
      map['student_registration'] ?? '',
      map['student_name'] ?? '',
      map['student_type'] ?? '',
      map['meal_description'] ?? '',
      map['status_description'] ?? '',
      map['justification_description'] ?? '',
      map['description'] ?? '',
      map['permanent_id'] ?? 0,
      '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  String statusImage() {
    if (idStatus == 1) {
      return path_image.analysis;
    } else if (idStatus == 2) {
      return path_image.awaitingPresence;
    } else if (idStatus == 3) {
      return path_image.waitPay;
    } else if (idStatus == 4) {
      return path_image.authorizedUse;
    } else if (idStatus == 5) {
      return path_image.used;
    } else if (idStatus == 6) {
      return path_image.canceled;
    } else if (idStatus == 7) {
      return path_image.canceled;
    }

    return '';
  }

  String qrCodeInfo() {
    var data = {
      'id': id,
      'student': student,
      'student_name': studentName,
      'status': status,
      'date': useDayDate,
      'date_str': useDay,
      'meal': meal
    };
    var jsonData = jsonEncode(data);
    final encrypted = EncryptUtil().encrypt(jsonData);
    return encrypted;
  }

  @override
  String toString() {
    return 'Ticket(id: $id, idStudent: $idStudent, idStatus: $idStatus, idMeal: $idMeal, useDayDate: $useDayDate, useDay: $useDay, student: $student, studentName: $studentName, type: $type, meal: $meal, status: $status, justification: $justification, text: $text, isPermanent: $isPermanent, solicitationDay: $solicitationDay)';
  }
}
