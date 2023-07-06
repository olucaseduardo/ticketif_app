import 'package:project_ifma_ticket/features/models/ticket.dart';

class ScreenArguments {
  final String? title;
  final List<Ticket>? userTickets;
  final bool? caeRequest;
  final int? idStudent;

  ScreenArguments(
      {this.title, this.userTickets, this.caeRequest, this.idStudent});
}
