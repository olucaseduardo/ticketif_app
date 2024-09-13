import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/dto/request_permanent.dart';
import 'package:ticket_ifma/features/dto/request_ticket_model.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/models/authorization.dart';
import 'package:ticket_ifma/features/models/ticket.dart';

import './tickets_api_repository.dart';

class TicketsApiRepositoryImpl implements TicketsApiRepository {
  @override
  Future<List<Ticket>> findAllTickets(int idStudent) async {
    try {
      final result = await DioClient().get("/ticket/$idStudent");

      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<List<PermanentModel>> findAllPermanents(int idStudent) async {
    try {
      final result = await DioClient().get("/permanent/$idStudent");

      return result.data.map<PermanentModel>((t) => PermanentModel.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar autorizações permanentes do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar autorizações permanentes do usuário');
    }
  }

  @override
  Future<void> requestTicket(RequestTicketModel ticket) async {
    try {
      log(ticket.toMap().toString());
      await DioClient().post("/ticket", data: ticket.toMap());
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
  Future<void> changeConfirmTicket(int idTicket, int statusId, int idMeal) async {
    try {
      await DioClient().patch("/confirm-ticket/$idTicket", data: {
        "status_id": statusId,
        "meal_id": idMeal,
      });
    } on DioError catch (e, s) {
      log("Erro ao alterar status do ticket", error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao solicitar ticket');
    }
  }

  @override
  Future<List<Ticket>> findAllDailyTickets(String date) async {
    try {
      final result = await DioClient().get("/tickets-daily?daily=$date");

      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<List<Ticket>> findPeriodTickets(
      String initialDate, String finalDate) async {
    try {
      final result = await DioClient().get(
          "/tickets-period?month_initial=$initialDate&month_final=$finalDate");
      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<void> requestPermanent(List<RequestPermanent> tickets) async {
    try {
      for (var element in tickets) {
        log(element.toString());
        var a = tickets.map((e) => e.toMap()).toList().toString();
        log(a);
      }
      await DioClient().post(
        "/permanent",
        data: jsonEncode(
            {"permanent_days": tickets.map((e) => e.toMap()).toList()}),
      );
    } on DioError catch (e, s) {
      log("Erro ao solicitar tickets permanentes", error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao solicitar tickets permanentes');
    }
  }

  @override
  Future<List<Authorization>> findAllNotAuthorized() async {
    try {
      final result = await DioClient().get("/not-authorized");

      return result.data
          .map<Authorization>((t) => Authorization.fromMap(t))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar autorizações não tratadas', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao buscar autorizações não tratadas');
    }
  }

  @override
  Future<void> changeStatusAuthorization(
      List<StudentAuthorization> authorizations, int status) async {
    try {
      await DioClient().patch(
        "/not-authorized/$status",
        data: jsonEncode(
            {"authorizations": authorizations.map((e) => e.toMap()).toList()}),
      );
    } on DioError catch (e, s) {
      log('Erro ao atualizar autorizações', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar autorizações');
    }
  }
  
  @override
  Future<void> deleteAllPermanents() async {
    try {
      await DioClient().delete('/tickets-permanents-delete');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os permanentes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os permanentes');
    }
  }
  
  @override
  Future<void> deleteAllTickets() async {
    try {
      await DioClient().delete('/tickets-delete');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os tickets', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os tickets');
    }
  }
}
