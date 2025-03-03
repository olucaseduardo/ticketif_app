import 'package:ticket_ifma/features/dto/request_permanent.dart';
import 'package:ticket_ifma/features/dto/request_ticket_model.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/models/ticket.dart';

abstract class TicketsApiRepository {
  Future<List<Ticket>> findAllTickets(String matricula);
  Future<List<PermanentModel>> findAllPermanents(String matricula);
  Future<List<Ticket>> findAllDailyTickets(String date);
  Future<List<Ticket>> findPeriodTickets(String initialDate, String finalDate);
  Future<int> requestTicket(RequestTicketModel ticket);
  Future<List<int>> requestPermanent(RequestPermanent tickets);
  Future<void> findAllInAnalisePermanents();
  Future<void> changeStatusTicket(int idTicket, int statusId);
  Future<void> changeConfirmTicket(int idTicket, int statusId);
  Future<void> changeStatusAuthorizationPermanents(
      List<int> permanentsId, int status);
  Future<void> deleteAllPermanents();
  Future<void> deleteAllTickets();
}
