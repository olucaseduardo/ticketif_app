import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/classes_screen/classes_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/period_report_screen/period_report_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/restaurant/qr_screen/qr_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/search_student_screen/search_student_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/ticket_evaluate_screen/ticket_evaluate_controller.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/auth_check/auth_check_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/cae_home_screen/cae_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/cae/authorizations_screens/cae_authorization_controller.dart';
import 'package:project_ifma_ticket/features/views/home_screen/home_controller.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/login_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/daily_report_screen/report_controller.dart';
import 'package:project_ifma_ticket/features/views/request_ticket_screen/request_ticket_controller.dart';
import 'package:project_ifma_ticket/features/views/adm/restaurant/restaurant_home/restaurant_controller.dart';

final requestTicketProvider =
    ChangeNotifierProvider.autoDispose<RequestTicketController>(
  (ref) => RequestTicketController(),
);

final homeProvider = ChangeNotifierProvider.autoDispose<HomeController>(
  (ref) => HomeController(),
);

final caeProvider = ChangeNotifierProvider.autoDispose<CaeController>(
  (ref) => CaeController(),
);

final classesProvider = ChangeNotifierProvider.autoDispose<ClassesController>(
  (ref) => ClassesController(),
);

final ticketEvaluateProvider =
    ChangeNotifierProvider.autoDispose<TicketEvaluateController>(
  (ref) => TicketEvaluateController(),
);

final loginProvider = ChangeNotifierProvider.autoDispose<LoginController>(
  (ref) => LoginController(),
);

final authCheckProvider =
    ChangeNotifierProvider.autoDispose<AuthCheckController>(
  (ref) => AuthCheckController(),
);

final reportProvider = ChangeNotifierProvider.autoDispose<ReportController>(
  (ref) => ReportController(),
);

final periodReportProvider =
    ChangeNotifierProvider.autoDispose<PeriodReportController>(
  (ref) => PeriodReportController(),
);

final restaurantProvider =
    ChangeNotifierProvider.autoDispose<RestaurantController>(
  (ref) => RestaurantController(),
);

final caePermanentProvider =
    ChangeNotifierProvider.autoDispose<CaeAuthorizationController>(
  (ref) => CaeAuthorizationController(),
);

final searchStudentProvider =
    ChangeNotifierProvider.autoDispose<SearchStudentController>(
  (ref) => SearchStudentController(),
);

final qrProvider = ChangeNotifierProvider.autoDispose<QrController>(
  (ref) => QrController(),
);
