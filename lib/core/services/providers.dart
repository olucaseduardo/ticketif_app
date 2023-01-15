import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/home/ui/home_controller.dart';
import 'package:project_ifma_ticket/features/requestTicket/ui/request_ticket_controller.dart';

final requestTicketProvider =
    ChangeNotifierProvider.autoDispose<RequestTicketController>(
        (ref) => RequestTicketController());

final homeProvider = ChangeNotifierProvider.autoDispose<HomeController>(
    (ref) => HomeController());
