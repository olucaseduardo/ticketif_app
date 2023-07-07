import 'package:project_ifma_ticket/features/models/list_tables_model.dart';

abstract class RequestTablesApi {
  Future<ListTablesModel> listTables();
}
