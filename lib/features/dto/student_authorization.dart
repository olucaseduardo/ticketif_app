// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudentAuthorization {
  final String matricula;
  final int idStudent;
  final String justification;
  final String meal;
  final String days;

  StudentAuthorization({
    required this.matricula,
    required this.idStudent,
    required this.justification,
    required this.meal,
    required this.days,
  });

  @override
  String toString() {
    return 'StudentAuthorization(matricula: $matricula, idStudent: $idStudent, justification: $justification, meal: $meal, days: $days)';
  }
}
