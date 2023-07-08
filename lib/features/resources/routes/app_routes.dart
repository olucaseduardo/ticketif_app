
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';

import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/views/auth_adm/login_adm_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/cae_home_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/classes_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/daily_report_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/period_report_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/search_student_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/ticket_evaluate_screen.dart';
import 'package:project_ifma_ticket/features/views/historic_screen.dart';
import 'package:project_ifma_ticket/features/views/home_screen.dart';
import 'package:project_ifma_ticket/features/views/login_screen.dart';
import 'package:project_ifma_ticket/features/views/qr_screen.dart';
import 'package:project_ifma_ticket/features/views/request_ticket_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String historicRoute = '/historic';
  static const String requestTicketRoute = '/requestTicket';
  static const String qrRoute = '/qrCode';
  static const String admLoginRoute = '/admLogin';
  // CAE ROUTES
  static const String caeHomeRoute = '/caeHome';
  static const String caeClassesRoute = "/classes";
  static const String caeDailyReportRoute = '/dailyReport';
  static const String caePeriodReportRoute = '/periodReport';
  static const String caeTicketEvaluateRoute = '/ticketEvaluate';
  static const String caeSearchStudentRoute = '/searchStudent';

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
                  caeRequest: args?.caeRequest,
                  idStudent: args?.idStudent,
                ));

      // CAE ROUTES
      case caeHomeRoute:
        return MaterialPageRoute(builder: (_) => const CaeHomeScreen());
      case caeClassesRoute:
        return MaterialPageRoute(builder: (_) => ClassesScreen(
          title: args?.title as String,
          isPermanent: args?.isPermanent as bool,
        ));
      case caeDailyReportRoute:
        return MaterialPageRoute(builder: (_) => const DailyReportScreen());
      case caePeriodReportRoute:
        return MaterialPageRoute(builder: (_) => const PeriodReportScreen());
      case caeTicketEvaluateRoute:
        return MaterialPageRoute(builder: (_) =>  TicketEvaluateScreen(
          title: args!.title as String,
          tickets: args.tickets as List<Ticket>,
        ));
      case caeSearchStudentRoute:
        return MaterialPageRoute(builder: (_) => const SearchStudentScreen());
      case qrRoute:
        return MaterialPageRoute(builder: (_) => const QrScreen());
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
