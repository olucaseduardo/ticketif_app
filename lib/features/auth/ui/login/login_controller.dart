import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';

class LoginController {
  onLoginTap() {
    navigatorKey.currentState!.pushNamed(AppRouter.homeRoute);
  }
}
