enum Meal { breakfast, lunch, dinner, supper }

enum Status { analysis, payment, cancelled, refused, approved, used }

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
