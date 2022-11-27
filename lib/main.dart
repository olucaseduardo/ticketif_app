import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/auth/ui/login/login_screen.dart';
import 'package:project_ifma_ticket/features/home/ui/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const App()));
}
