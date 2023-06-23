import 'dart:convert';

import 'package:project_ifma_ticket/core/utils/path_image.dart' as path_image;

class Ticket {
  final int id;
  final int idStudent;
  final String useDayDate;
  final String useDay;
  final String student;
  final String meal;
  final String status;
  final String justification;
  final String text;
  final int isPermanent;
  final String solicitationDay;
  

  Ticket(
    this.id,
    this.idStudent,
    this.useDayDate,
    this.useDay,
    this.student,
    this.meal,
    this.status,
    this.justification,
    this.text,
    this.isPermanent,
    this.solicitationDay,
  );
// "id": 1,
//         "student_id": 1,
//         "week_id": 1,
//         "meal_id": 2,
//         "status_id": 5,
//         "justification_id": 1,
//         "solicitation_day": "2023-02-12 00:00:00.000",
//         "use_day": "Segunda-Feira",
//         "payment_day": "2023-02-13 00:00:00.000",
//         "text": "",
//         "is_permanent": 1,
//         "status_description": "Utilizado",
//         "justification_description": "Contra-turno",
//         "meal_description": "Almoço"
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idStudent': idStudent,
      'use_day': useDay,
      'use_day_date': useDayDate,
      'student': student,
      'meal_description': meal,
      'status_description': status,
      'justification_description': justification,
      'text': text,
      'is_permanent': isPermanent,
      'solicitation_day': solicitationDay
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      map['id'] ?? 0,
      map['idStudent'] ?? 0,
      map['use_day_date'] ?? '',
      map['use_day'] ?? '',
      map['student'] ?? '',
      map['meal_description'] ?? '',
      map['status_description'] ?? '',
      map['justification_description'] ?? '',
      map['text'] ?? '',
      map['is_permanent'] ?? 0,
      map['solicitation_day'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  String statusImage() {
    if (status == 'Em análise') {
      return path_image.analysis;
    } else if (status == 'Confirmar presença') {
      return path_image.awaitingPresence;
    } else if (status == 'Aguardando pagamento') {
      return path_image.waitPay;
    } else if (status == 'Utilização autorizada') {
      return path_image.authorizedUse;
    } else if (status == 'Utilizado') {
      return path_image.used;
    } else if (status == 'Cancelado') {
      return path_image.canceled;
    } else if (status == 'Não autorizado') {
      return path_image.canceled;
    }
    
    return '';
  }

  // String statusText() {
  //   if (status == 'Em análise') {
  //     return "Em análise";
  //   } else if (status == 'Aguardando confimação de presença') {
  //     return "Aguardando confimação de presença";
  //   } else if (status == 'Aguardando pagamento') {
  //     return "Aguardando pagamento";
  //   } else if (status == 'Aprovado') {
  //     return "Utilização autorizada";
  //   } else if (status == 'Usado') {
  //     return "Utilizado";
  //   } else if (status == 'Cancelado') {
  //     return "Cancelado";
  //   } else if (status == 'Não autorizado') {
  //     return "Cancelado";
  //   }
  //   return '';
  // }

  String actionImage() {
    if (status == 'Utilização autorizada') {
      return path_image.qrUse;
    }
    return '';
  }

  String actionText() {
    if (status == 'analysis') {
      return 'Cancelar';
    } else if (status == 'awaiting_presence') {
      return 'Confirmar Presença';
    }
    return '';
  }
}
