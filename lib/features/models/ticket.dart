import 'package:project_ifma_ticket/core/utils/path_image.dart' as path_image;

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

  String statusImage() {
    if (status == 'analysis') {
      return path_image.analysis;
    } else if (status == 'awaiting_presence') {
      return path_image.awaitingPresence;
    } else if (status == 'wait_pay') {
      return path_image.waitPay;
    } else if (status == 'authorized_use') {
      return path_image.authorizedUse;
    } else if (status == 'used') {
      return path_image.used;
    } else if (status == 'canceled') {
      return path_image.canceled;
    }
    return '';
  }

  String actionImage() {
    if (status == 'wait_pay') {
      return path_image.qrPay;
    } else if (status == 'autorized_use') {
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
