import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/services/dio_client.dart';
import 'package:project_ifma_ticket/features/dto/request_ticket_model.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';

import './tickets_api_repository.dart';

class TicketsApiRepositoryImpl implements TicketsApiRepository {
  @override
  Future<List<Ticket>> findAllTickets(int idStudent) async {
    try {
      final result =
          await DioClient().get("/ticket/$idStudent");

      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<void> requestTicket(RequestTicketModel ticket) async {
    try {
     await DioClient().post(
        "/ticket",
        data: ticket.toMap()
      );
    } on DioError catch (e, s) {
      log("Erro ao solicitar ticket", error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao solicitar ticket');
    }
  }
  
  @override
  Future<void> changeStatusTicket(int idTicket, int statusId) async {
    try {
      await DioClient().patch("/ticket/$idTicket", data: {
        "status_id": statusId,
      });
    } on DioError catch (e, s) {
      log("Erro ao alterar status do ticket", error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao solicitar ticket');
    }
  }
  
  @override
  Future<List<Ticket>> findAllDailyTickets(String date) async{
    try {
      final result =
          await DioClient().get("/tickets-daily?daily=$date");

      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }
  
  @override
  Future<List<Ticket>> findPeriodTickets(String initialDate, String finalDate)async {
    try {
      final result =
          await DioClient().get("/tickets-period?month_initial=$initialDate&month_final=$finalDate");
      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }
}
