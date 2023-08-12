import 'package:project_ifma_ticket/features/dto/request_permanent.dart';
import 'package:project_ifma_ticket/features/dto/request_ticket_model.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';

abstract class TicketsApiRepository {
  Future<List<Ticket>> findAllTickets(int idStudent);
  Future<List<Ticket>> findAllDailyTickets(String date);
  Future<List<Ticket>> findPeriodTickets(String initialDate, String finalDate);
  Future<void> requestTicket(RequestTicketModel ticket);
  Future<void> requestPermanent(List<RequestPermanent> tickets);
  Future<void> findAllNotAuthorized();
  Future<void> changeStatusTicket(int idTicket, int statusId);
}
