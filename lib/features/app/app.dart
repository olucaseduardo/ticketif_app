import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_theme.dart';
import 'package:project_ifma_ticket/features/views/auth_check.dart';
import 'package:project_ifma_ticket/features/views/cae/cae_home_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/daily_report_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/period_report_screen.dart';
import 'package:project_ifma_ticket/features/views/cae/ticket_evaluate_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, child) => MaterialApp(
        title: 'Ticket IFMA',
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        theme: TicketTheme.ticketTheme,
        home: const CaeHomeScreen(), //const AuthCheck(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
