import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_theme.dart';
import 'package:project_ifma_ticket/features/views/login_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, child) => RefreshConfiguration(
        headerBuilder: () => const WaterDropHeader(),
        footerBuilder:  () => const ClassicFooter(),
        headerTriggerDistance: 80.0,
        springDescription:const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        maxOverScrollExtent :100,
        maxUnderScrollExtent:0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed : true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        child: MaterialApp(
          title: 'Ticket IFMA',
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          theme: TicketTheme.ticketTheme,
          home: const LoginScreen(),
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('pt', 'BR')],
        ),
      ),
    );
  }
}
