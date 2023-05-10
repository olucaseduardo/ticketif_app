import 'package:project_ifma_ticket/features/models/ticket.dart';

class ScreenArguments {
  final String title;
  final List<Ticket>? userTickets;

  ScreenArguments(this.title, this.userTickets);
}
