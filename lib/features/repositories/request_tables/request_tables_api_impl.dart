import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/services/dio_client.dart';
import 'package:ticket_ifma/features/repositories/request_tables/request_tables_api.dart';
import 'package:ticket_ifma/features/models/list_tables_model.dart';
import 'package:ticket_ifma/features/models/tables_model.dart';

class RequestTablesApiImpl implements RequestTablesApi {
  @override
  Future<ListTablesModel> listTables() async {
    try {
      final mealsResponse = await DioClient().get("/meal/");
      final justificationsResponse = await DioClient().get("/justification/");

      final List meals = mealsResponse.data['data']['meals'];
      final List justifications = justificationsResponse.data['data']['justifications'];

      final listTables = ListTablesModel(
        meals: meals.map((e) => TablesModel.fromMap(e)).toList(),
        justifications:
            justifications.map((e) => TablesModel.fromMap(e)).toList(),
      );

      return listTables;
    } on DioError catch (e, s) {
      log('Erro ao buscar lista de meals e justifications',
          error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao buscar lista de meals e justifications');
    }
  }
}
