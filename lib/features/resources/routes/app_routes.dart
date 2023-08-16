import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/authorization.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';

import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/auth_adm/login_adm_screen.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/auth_check/auth_check.dart';
import 'package:project_ifma_ticket/features/views/adm/authorizations_screens/authorization_classes/authorization_classes_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/authorizations_screens/authorization_evaluate/authorization_evaluate_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/cae_home_screen/cae_home_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/classes_screen/classes_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/daily_report_screen/daily_report_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/list_tickets_screen/list_tickets_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/period_report_screen/period_report_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/search_student_screen/search_student_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/ticket_evaluate_screen/ticket_evaluate_screen.dart';
import 'package:project_ifma_ticket/features/views/historic_screen/historic_screen.dart';
import 'package:project_ifma_ticket/features/views/home_screen/home_screen.dart';
import 'package:project_ifma_ticket/features/views/auth_screens/auth_student/login_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/qr_screen/qr_screen.dart';
import 'package:project_ifma_ticket/features/views/request_ticket_screen/request_ticket_screen.dart';
import 'package:project_ifma_ticket/features/views/adm/restaurant_home/restaurant_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String historicRoute = '/historic';
  static const String requestTicketRoute = '/requestTicket';
  static const String qrRoute = '/qrCode';
  static const String admLoginRoute = '/admLogin';
  static const String dailyReportRoute = '/dailyReport';
  static const String restaurantHomeRoute = '/restaurantHome';
  static const String authCheck = '/authCheck';
  // CAE ROUTES
  static const String caeHomeRoute = '/caeHome';
  static const String caeClassesRoute = "/classes";
  static const String authorizationClassesRoute = "/authorizationClasses";
  static const String authorizationEvaluateRoute = "/authorizationEvaluate";
  static const String caePeriodReportRoute = '/periodReport';
  static const String caeTicketEvaluateRoute = '/ticketEvaluate';
  static const String caeSearchStudentRoute = '/searchStudent';
  static const String listTickets = '/listTickets';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments? args = settings.arguments as ScreenArguments?;
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case admLoginRoute:
        return MaterialPageRoute(builder: (_) => const LoginAdmScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case historicRoute:
        return MaterialPageRoute(
            builder: (_) => HistoricScreen(
                  title: args!.title as String,
                  userTickets: args.tickets as List<Ticket>,
                ));
      case requestTicketRoute:
        return MaterialPageRoute(
            builder: (_) => RequestTicket(
                  title: args?.title,
                  caeRequest: args?.cae,
                  idStudent: args?.idStudent,
                ));

      // CAE ROUTES
      case caeHomeRoute:
        return MaterialPageRoute(builder: (_) => const CaeHomeScreen());
      case caeClassesRoute:
        return MaterialPageRoute(
            builder: (_) => ClassesScreen(
                  title: args?.title as String,
                  isPermanent: args?.isPermanent as bool,
                ));
      case authorizationClassesRoute:
        return MaterialPageRoute(
            builder: (_) => AuthorizationClassesScreen(
                  title: args?.title as String,
                ));

      case authorizationEvaluateRoute:
        return MaterialPageRoute(
            builder: (_) => AuthorizationEvaluateScreen(
                  title: args?.title as String,
                  authorizations:
                      args!.authorizations as Map<String, List<Authorization>>,
                ));
      case dailyReportRoute:
        return MaterialPageRoute(
            builder: (_) => DailyReportScreen(
                  cae: args!.cae as bool,
                ));
      case caePeriodReportRoute:
        return MaterialPageRoute(builder: (_) => const PeriodReportScreen());
      case caeTicketEvaluateRoute:
        return MaterialPageRoute(
            builder: (_) => TicketEvaluateScreen(
                  title: args!.title as String,
                  tickets: args.tickets as List<Ticket>,
                ));
      case listTickets:
        return MaterialPageRoute(
            builder: (_) => ListTicketsScreen(
                  title: args!.title as String,
                  tickets: args.tickets as List<Ticket>,
                  description: args.description as String,
                  subtitle: args.subtitle as String,
                ));
      case caeSearchStudentRoute:
        return MaterialPageRoute(builder: (_) => const SearchStudentScreen());
      case qrRoute:
        return MaterialPageRoute(builder: (_) => const QrScreen());
      case restaurantHomeRoute:
        return MaterialPageRoute(builder: (_) => const RestaurantScreen());
      case authCheck:
        return MaterialPageRoute(builder: (_) => const AuthCheck());
      default:
        return MaterialPageRoute(
            builder: (_) => const RouteErrorScreen(
                title: 'Rota não encontrada',
                message: 'Erro! A rota {settings.name} não foi encontrada.'));
    }
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
