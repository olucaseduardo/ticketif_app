import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/cae_home_screen.dart';
import 'package:ticket_ifma/features/views/home_screen/home_screen.dart';
import 'package:ticket_ifma/features/views/auth_screens/auth_student/login_screen.dart';
import 'package:ticket_ifma/features/views/adm/restaurant/restaurant_home/restaurant_screen.dart';

class AuthCheck extends ConsumerStatefulWidget {
  const AuthCheck({super.key});

  @override
  ConsumerState<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends ConsumerState<AuthCheck> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ref.read(authCheckProvider).verify();
    ref.read(authCheckProvider).isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(authCheckProvider);

    if (controller.isLoading) {
      return Scaffold(body: Loader.loader());
    } else if (controller.check && !controller.cae && !controller.restaurant) {
      return const HomeScreen();
    } else if (controller.check && controller.cae) {
      return const CaeHomeScreen();
    } else if (controller.check && controller.restaurant) {
      return const RestaurantScreen();
    } else {
      return const LoginScreen();
    }
  }
}
