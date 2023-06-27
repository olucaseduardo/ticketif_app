import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/views/home_screen.dart';
import 'package:project_ifma_ticket/features/views/login_screen.dart';

class AuthCheck extends ConsumerStatefulWidget {
  const AuthCheck({super.key});

  @override
  ConsumerState<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends ConsumerState<AuthCheck> {
  @override
  void initState() {
    ref.read(authCheckProvider).verify();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(authCheckProvider);

    if (controller.isLoading) {
      return Scaffold(body: Loader.loader());
    } else if (controller.check) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
