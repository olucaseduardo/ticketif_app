import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_class.dart';

class ClassesScreen extends ConsumerStatefulWidget {
  const ClassesScreen({super.key});

  @override
  ConsumerState<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends ConsumerState<ClassesScreen> {
  @override
  void initState() {
    ref.read(caeProvider)
        .loadDataTickets(DateUtil.getDateUSStr(DateUtil.dateTime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitações por turmas'),
      ),
      body: Visibility(
        visible: !controller.isLoading,

        replacement: Loader.loader(),
        
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Visibility(
            visible: !controller.error,

            replacement: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/alert.png'),
                  
                  const Text(
                    'Erro ao carregar as solicitações por turmas',
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
              crossAxisAlignment: CrossAxisAlignment.start,
          
              children: [
                TextField(
                  onChanged: (value) => controller.filterClasses(value),
                  decoration: const InputDecoration(
                    fillColor: AppColors.gray800,
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green500),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
          
                const SizedBox(
                  height: 8,
                ),
          
                const Divider(),
                
                const Text("Turmas"),
                const SizedBox(
                  height: 8,
                ),
                
                Visibility(
                  visible: controller.filteredClasses.isNotEmpty,
                  
                  replacement: const Expanded(
                    child: Center(
                      child: Text(
                        'Nenhuma solicitação encontrada',
                        style: AppTextStyle.normalText,
                      ),
                    ),
                  ),

                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredClasses.length,
                      itemBuilder: (context, index) => CommonTileClass(
                          title:
                              'Turma: ${controller.dailyClasses.keys.elementAt(index)}',
                          subtitle:
                              'Total: ${controller.dailyClasses[controller.filteredClasses[index]]!.length}',
                          function: () => Navigator.pushNamed(
                            context,
                            AppRouter.caeTicketEvaluateRoute,
                            arguments: ScreenArguments(
                              tickets: 
                                controller.dailyClasses.values.elementAt(index)
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
