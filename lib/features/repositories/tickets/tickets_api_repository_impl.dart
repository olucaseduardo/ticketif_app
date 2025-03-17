import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  Future<List<Ticket>> findAllTickets(String matricula) async {
    try {
      final result = await DioClient().get("/student/$matricula/ticket");
      return result.data["data"]["tickets"].map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<List<PermanentModel>> findAllPermanents(String matricula) async {
    try {
      final result = await DioClient().get("/student/$matricula/ticket/permanent");
      return result.data["data"]["permanents"].map<PermanentModel>((t) => PermanentModel.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar autorizações permanentes do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar autorizações permanentes do usuário');
    }
  }

  @override
  Future<int> requestTicket(RequestTicketModel ticket) async {
    try {
      final response = await DioClient().post("/ticket/", data: ticket.toMap());
      return response.data["data"]["id"];
    } on DioError catch (e, s) {
      log("Erro ao solicitar ticket", error: e.response, stackTrace: s);
      throw RepositoryException(message: e.response?.data["message"]);
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
  Future<void> changeConfirmTicket(int idTicket, int statusId) async {
    try {
      await DioClient().patch("/ticket/$idTicket", data: {
        "status_id": statusId,
      });
    } on DioError catch (e, s) {
      log("Erro ao alterar status do ticket", error: e, stackTrace: s);
      if (e.response?.data["message"] != null) {
        throw RepositoryException(message: e.response?.data["message"]);
      }
      throw RepositoryException(message: 'Erro ao atualizar o ticket');
    }
  }

  @override
  Future<List<Ticket>> findAllDailyTickets(String date) async {
    try {
      final result = await DioClient().get("/ticket/?date=$date");

      return result.data["data"]["tickets"].map<Ticket>((t) => Ticket.fromMap(t)).toList();
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
          "/ticket/?status_id=5&start_date=$initialDate&end_date=$finalDate");
      return result.data["data"]["tickets"].map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }

  @override
  Future<List<int>> requestPermanent(RequestPermanent tickets) async {
    try {
      final response = await DioClient().post(
        "/ticket/permanent/",
        data: tickets.toMap(),
      );
      return List<int>.from(response.data["data"]["id"]);
    } on DioError catch (e, s) {
      log("Erro ao solicitar tickets permanentes", error: e.message, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao solicitar tickets permanentes');
    }
  }

  @override
  Future<List<Authorization>> findAllInAnalisePermanents() async {
    try {
      final result = await DioClient().get("/ticket/permanent/?status_id=1");

      return result.data["data"]["permanents"]
          .map<Authorization>((t) => Authorization.fromMap(t))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar permanentes não autorizados', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao buscar permanentes não autorizados');
    }
  }

  @override
  Future<void> changeStatusAuthorizationPermanents(List<int> permanentsId, int status) async {
    try {
      for (int id in permanentsId) {
        await DioClient().patch(
          "/ticket/permanent/$id",
          data: {
            "status_id": status
          },
        );
      }
    } on DioError catch (e, s) {
      log('Erro ao atualizar autorizações', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar autorizações');
    }
  }
  
  @override
  Future<void> deleteAllPermanents() async {
    try {
      await DioClient().delete('/ticket/permanent/');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os permanentes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os permanentes');
    }
  }
  
  @override
  Future<void> deleteAllTickets() async {
    try {
      await DioClient().delete('/ticket/');
    } on DioError catch (e, s) {
      log('Erro ao deletar todos os tickets', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os tickets');
    }
  }

  @override
  Future<void> getPermanentTicketDaily(String registration) async {
    try {
      await DioClient().get('/student/$registration/ticket/permanent/daily');
    } on DioError catch (e, s) {
      log('Erro ao gerar tickets diários de permanentes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar todos os permanentes');
    }
  }
}
