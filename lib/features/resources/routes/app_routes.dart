import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/auth/ui/login/login_screen.dart';
import 'package:project_ifma_ticket/features/historic/ui/historic_screen.dart';
import 'package:project_ifma_ticket/features/home/ui/home_screen.dart';
import 'package:project_ifma_ticket/features/resources/routes/arguments.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String historicRoute = '/historic';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments args = settings.arguments as ScreenArguments;
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case historicRoute:
        return MaterialPageRoute(
            builder: (_) => HistoricScreen(
                  title: args.title,
                ));
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
