import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/config/env.dart';
import 'package:project_ifma_ticket/features/app/app.dart';

Future<void> main() async {
  await Env.i.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}
