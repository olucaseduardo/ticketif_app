import 'package:project_ifma_ticket/features/models/ticket.dart';

abstract class TicketsApiRepository {
  Future<List<Ticket>> findAllTickets(int idStudent);
}
