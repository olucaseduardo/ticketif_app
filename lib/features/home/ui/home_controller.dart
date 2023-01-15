import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/arguments.dart';

class HomeController extends ChangeNotifier {
  onRequestTicketTap() {}
  onLogoutTap() {}
  onTicketsTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Seus tickets'));
  }

  onAnalysisTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Tickets em análise'));
  }

  onHistoricTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Histórico'));
  }
}
