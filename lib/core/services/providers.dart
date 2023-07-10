import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/controllers/auth_check_controller.dart';
import 'package:project_ifma_ticket/features/controllers/cae_controller.dart';
import 'package:project_ifma_ticket/features/controllers/historic_controller.dart';
import 'package:project_ifma_ticket/features/controllers/home_controller.dart';
import 'package:project_ifma_ticket/features/controllers/login_controller.dart';
import 'package:project_ifma_ticket/features/controllers/report_controller.dart';
import 'package:project_ifma_ticket/features/controllers/request_ticket_controller.dart';
import 'package:project_ifma_ticket/features/controllers/restaurant_controller.dart';

final requestTicketProvider =
    ChangeNotifierProvider.autoDispose<RequestTicketController>(
        (ref) => RequestTicketController());

final homeProvider = ChangeNotifierProvider.autoDispose<HomeController>(
    (ref) => HomeController());

final caeProvider =
    ChangeNotifierProvider.autoDispose<CaeController>((ref) => CaeController());

final historicProvider = ChangeNotifierProvider.autoDispose<HistoricController>(
    (ref) => HistoricController());

final loginProvider = ChangeNotifierProvider.autoDispose<LoginController>(
    (ref) => LoginController());

final authCheckProvider =
    ChangeNotifierProvider.autoDispose<AuthCheckController>(
        (ref) => AuthCheckController());

final reportProvider = ChangeNotifierProvider.autoDispose<ReportController>(
    (ref) => ReportController());

final restaurantProvider = ChangeNotifierProvider.autoDispose<RestaurantController>(
    (ref) => RestaurantController());
