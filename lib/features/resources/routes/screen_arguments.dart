import 'package:TicketIFMA/features/models/authorization.dart';
import 'package:TicketIFMA/features/models/ticket.dart';

class ScreenArguments {
  final String? title;
  final String? subtitle;
  final String? description;
  final List<Ticket>? tickets;
  final Map<String, List<Authorization>>? authorizations;
  final bool? cae;
  final int? idStudent;
  final bool? isPermanent;

  ScreenArguments({
    this.title,
    this.tickets,
    this.cae,
    this.idStudent,
    this.isPermanent,
    this.subtitle,
    this.description,
    this.authorizations,
  });
}
