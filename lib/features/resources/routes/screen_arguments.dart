import 'package:project_ifma_ticket/features/models/ticket.dart';

class ScreenArguments {
  final String? title;
  final List<Ticket>? tickets;
  final bool? caeRequest;
  final int? idStudent;
  final bool? isPermanent;

  ScreenArguments({
    this.title,
    this.tickets,
    this.caeRequest,
    this.idStudent,
    this.isPermanent,
  });
}
