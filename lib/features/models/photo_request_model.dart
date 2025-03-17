import 'dart:convert';

import 'package:ticket_ifma/core/utils/path_image.dart' as path_image;

class PhotoRequestModel {
  static const approved = "Aprovado";
  static const canceled = "Cancelado";
  static const analysis = "Em Análise";
  static const reproved = "Reprovado";
  int id;
  int studentId;
  String status;
  DateTime createdAt;
  String studentRegistration;

  PhotoRequestModel(
      {required this.id,
      required this.studentId,
      required this.status,
      required this.createdAt,
      required this.studentRegistration
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'status': status,
      'created_at': createdAt
    };
  }

  String toJson() => json.encode(toMap());

  factory PhotoRequestModel.fromMap(Map<String, dynamic> map) {
    return PhotoRequestModel(
        id: map['id'],
        studentId: map['student_id'],
        status: map['status'] ,
        createdAt: DateTime.parse(map['created_at']),
        studentRegistration: map['student_registration']
    );
  }

  factory PhotoRequestModel.fromJson(String source) =>
      PhotoRequestModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  toString() {
    return 'PhotoRequestModel(id: $id, student_id: $studentId, student_registration:$studentRegistration, status: $status, created_at: $createdAt)';
  }

  String statusImage() {
    if (status == analysis) {
      return path_image.analysis;
    } else if (status == approved) {
      return path_image.authorizedUse;
    } else if (status == canceled) {
      return path_image.canceled;
    } else if (status == reproved) {
      return path_image.canceled;
    }

    return '';
  }
}
