import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/services/dio_client.dart';
import 'package:project_ifma_ticket/features/repositories/request_tables/request_tables_api.dart';
import 'package:project_ifma_ticket/features/models/list_tables_model.dart';
import 'package:project_ifma_ticket/features/models/tables_model.dart';

class RequestTablesApiImpl implements RequestTablesApi {
  @override
  Future<ListTablesModel> listTables() async {
    try {
      final result = await DioClient().get("/tables");

      final List meals = result.data['meals'];
      final List justifications = result.data['justifications'];

      final listTables = ListTablesModel(
        meals: meals.map((e) => TablesModel.fromMap(e)).toList(),
        justifications:
            justifications.map((e) => TablesModel.fromMap(e)).toList(),
      );

      return listTables;
    } on DioError catch (e, s) {
      log('Erro ao buscar lista de meals e justifications', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar lista de meals e justifications');
    }
  }
}
