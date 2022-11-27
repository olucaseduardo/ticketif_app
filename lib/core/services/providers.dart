import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/requestTicket/ui/request_ticket_controller.dart';

final requestTicketProvider =
    ChangeNotifierProvider.autoDispose<RequestTicketController>(
        (ref) => RequestTicketController());
