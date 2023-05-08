import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/services/dio_client.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';

import './tickets_api_repository.dart';

class TicketsApiRepositoryImpl implements TicketsApiRepository {
  @override
  Future<List<Ticket>> findAllTickets(int idStudent) async {
    try {
      final result =
          await DioClient().auth().get("/tickets?id_student=$idStudent");

      return result.data.map<Ticket>((t) => Ticket.fromMap(t)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tickets do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tickets do usuário');
    }
  }
}
