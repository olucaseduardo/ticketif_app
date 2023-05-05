import 'package:project_ifma_ticket/core/utils/enums_util.dart';

class Ticket {
  final int id;
  final int idStudent;
  final String date;
  final String student;
  final Meal meal;
  final Status status;
  final String reason;
  final String text;

  Ticket(this.id, this.idStudent, this.date, this.student, this.meal,
      this.status, this.reason, this.text);
}
