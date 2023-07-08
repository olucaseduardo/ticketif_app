import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_student.dart';

class SearchStudentScreen extends ConsumerStatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  ConsumerState<SearchStudentScreen> createState() =>
      _SearchStudentScreenState();
}

class _SearchStudentScreenState extends ConsumerState<SearchStudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Matrícula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(
              height: 20,
            ),
            CommonTileStudent(
              function: () => Navigator.pushNamed(
                  context, AppRouter.requestTicketRoute,
                  arguments: ScreenArguments(
                      caeRequest: true,
                      idStudent: 1,
                      title: '20191BCC.CAX03848')),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 60,
          child: CommonButton(
            label: 'Buscar Matrícula',
            function: () {},
          ),
        ),
      ),
    );
  }
}
