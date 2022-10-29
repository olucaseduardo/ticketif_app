import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ifma_ticket/features/auth/ui/login/login_screen.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

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
        theme: ThemeData(
            primaryColor: AppColors.green500,
            fontFamily: GoogleFonts.inter().fontFamily),
        home: const LoginScreen(),
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
