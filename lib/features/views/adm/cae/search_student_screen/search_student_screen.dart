import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_student.dart';
import 'package:project_ifma_ticket/features/resources/widgets/error_results.dart';
import 'package:project_ifma_ticket/features/resources/widgets/without_results.dart';

class SearchStudentScreen extends ConsumerStatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  ConsumerState<SearchStudentScreen> createState() =>
      _SearchStudentScreenState();
}

class _SearchStudentScreenState extends ConsumerState<SearchStudentScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(searchStudentProvider).loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(searchStudentProvider);
    final allStudents = controller.filteredStudents;

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.i.showError('Erro ao carregar os estudantes');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Matrícula'),
      ),
      body: Visibility(
        visible: !controller.isLoading,
        replacement: Loader.loader(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Visibility(
            visible: !controller.error,
            replacement: const ErrorResults(
              msg: 'Voltar para a tela de início',
              msgError: 'Erro ao carregar os estudantes',
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.searchStudent(value),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Busca por matrícula",
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                Visibility(
                  visible: allStudents.isNotEmpty,
                  replacement:
                      const WithoutResults(msg: 'Nenhum estudante encontrado'),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: allStudents.length,
                      itemBuilder: (_, index) => CommonTileStudent(
                        student: allStudents.elementAt(index),
                        function: () => Navigator.pushNamed(
                          context,
                          AppRouter.requestTicketRoute,
                          arguments: ScreenArguments(
                            cae: true,
                            idStudent: allStudents.elementAt(index).id,
                            title: allStudents.elementAt(index).matricula,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
