import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_student.dart';

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
    ref.read(caeProvider).loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    final allStudents = controller.filteredStudents;

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

            replacement: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image.asset('assets/images/alert.png'),
                  const Text(
                    'Erro ao carregar os estudantes',
                    style: AppTextStyle.normalText,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: TextButton(
                      onPressed: () {
                        controller.onLogoutTap();
                        Navigator.pop(context);
                      },

                      child: Text(
                        'Voltar a tela inicial',
                        style: AppTextStyle.largeText
                            .copyWith(color: AppColors.green500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.searchStudent(value),

                  decoration: const InputDecoration(
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
                  height: 8,
                ),
                
                const Divider(),
                
                Visibility(
                  visible: allStudents.isNotEmpty,
                  replacement: const Expanded(
                    child: Center(
                      child: Text(
                        'Nenhum estudante encontrado',
                        style: AppTextStyle.normalText,
                      ),
                    ),
                  ),
                  
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: allStudents.length,
                      itemBuilder: (_, index) => CommonTileStudent(
                        student: allStudents.elementAt(index),
                        function: () => Navigator.pushNamed(
                            context, AppRouter.requestTicketRoute,
                            arguments: ScreenArguments(
                                caeRequest: true,
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
