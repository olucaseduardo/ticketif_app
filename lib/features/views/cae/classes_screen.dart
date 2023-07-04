import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_class.dart';

class ClassesScreen extends ConsumerWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitações por turmas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                fillColor: AppColors.gray800,
                filled: true,
                hintText: "Busca",
                prefixIcon: Icon(Icons.search, color: AppColors.green500),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),

            CommonTileClass(title: '20231A.CAX', subtitle: 'Total 3'),
          ],
        ),
      ),
    );
  }
}
