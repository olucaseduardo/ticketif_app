import 'package:flutter/material.dart';

import 'package:project_ifma_ticket/features/resources/routes/arguments.dart';
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments? args = settings.arguments as ScreenArguments?;
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case historicRoute:
        return MaterialPageRoute(
            builder: (_) => HistoricScreen(
                  title: args!.title,
                ));
      case requestTicketRoute:
        return MaterialPageRoute(
            builder: (_)=> const RequestTicket());
      case qrRoute:
        return MaterialPageRoute(
            builder: (_)=> const QrScreen());
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
