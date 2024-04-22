import 'package:TicketIFMA/features/models/list_tables_model.dart';

abstract class RequestTablesApi {
  Future<ListTablesModel> listTables();
}
