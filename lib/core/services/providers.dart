import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/views/adm/classes_screen/classes_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/ticket_evaluate_screen/ticket_evaluate_controller.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/auth_check/auth_check_controller.dart';
import 'package:project_ifma_ticket/features/controllers/cae_controller.dart';
import 'package:project_ifma_ticket/features/controllers/cae_permanent_controller.dart';
import 'package:project_ifma_ticket/features/controllers/historic_controller.dart';
import 'package:project_ifma_ticket/features/views/home_screen/home_controller.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/login_controller.dart';
import 'package:project_ifma_ticket/features/controllers/report_controller.dart';
import 'package:project_ifma_ticket/features/views/request_ticket_screen/request_ticket_controller.dart';
import 'package:project_ifma_ticket/features/controllers/restaurant_controller.dart';

final requestTicketProvider =
    ChangeNotifierProvider.autoDispose<RequestTicketController>(
        (ref) => RequestTicketController());

final homeProvider = ChangeNotifierProvider.autoDispose<HomeController>(
    (ref) => HomeController());

final caeProvider =
    ChangeNotifierProvider.autoDispose<CaeController>((ref) => CaeController());

final classesProvider =
    ChangeNotifierProvider.autoDispose<ClassesController>((ref) => ClassesController());

final ticketEvaluateProvider =
    ChangeNotifierProvider.autoDispose<TicketEvaluateController>((ref) => TicketEvaluateController());

final historicProvider = ChangeNotifierProvider.autoDispose<HistoricController>(
    (ref) => HistoricController());

final loginProvider = ChangeNotifierProvider.autoDispose<LoginController>(
    (ref) => LoginController());

final authCheckProvider =
    ChangeNotifierProvider.autoDispose<AuthCheckController>(
        (ref) => AuthCheckController());

final reportProvider = ChangeNotifierProvider.autoDispose<ReportController>(
    (ref) => ReportController());

final restaurantProvider =
    ChangeNotifierProvider.autoDispose<RestaurantController>(
        (ref) => RestaurantController());

final caePermanentProvider =
    ChangeNotifierProvider.autoDispose<CaePermanentController>(
        (ref) => CaePermanentController());
