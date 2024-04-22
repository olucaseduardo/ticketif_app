import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_ifma/core/navigation/special_navigation.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/theme/app_theme.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/views/auth_screens/auth_check/auth_check.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  App({super.key}) {
    Loader.i.navigatorKey = _navigatorKey;
    SpecialNavigation.i.navigatorKey = _navigatorKey;
    AppMessage.i.scaffoldMessagerKey = _scaffoldMessengerKey;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, child) => MaterialApp(
        title: 'Ticket IFMA',
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        scaffoldMessengerKey: _scaffoldMessengerKey,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        theme: TicketTheme.ticketTheme,
        home: const AuthCheck(),
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
