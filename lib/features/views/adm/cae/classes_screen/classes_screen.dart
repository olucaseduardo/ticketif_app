import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_class.dart';
import 'package:project_ifma_ticket/features/resources/widgets/error_results.dart';
import 'package:project_ifma_ticket/features/resources/widgets/without_results.dart';

class ClassesScreen extends ConsumerStatefulWidget {
  final String title;
  final bool isPermanent;
  const ClassesScreen({
    super.key,
    required this.title,
    this.isPermanent = false,
  });

  @override
  ConsumerState<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends ConsumerState<ClassesScreen> {
  @override
  void initState() {
    ref.read(classesProvider).loadDataTickets(
        date: DateUtil.getDateUSStr(DateUtil.dateTimeNow),
        isPermanent: widget.isPermanent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(classesProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.i.showError('Erro ao carregar as solicitações por turmas');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Visibility(
        visible: !controller.isLoading,

        replacement: Loader.loader(),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Visibility(
            visible: !controller.error,

            replacement: const ErrorResults(
              msg: 'Voltar para a tela de início',
              msgError: 'Erro ao carregar as solicitações por turmas',
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

                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),

                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredClasses.length,

                      itemBuilder: (context, index) => CommonTileClass(
                          title:
                              'Turma: ${controller.sortedDailyClasses.keys.elementAt(index)}',
                          subtitle:
                              'Total: ${controller.sortedDailyClasses[controller.filteredClasses[index]]!.length}',

                          function: () async {
                            dynamic list = await Navigator.pushNamed(
                              context,
                              AppRouter.caeTicketEvaluateRoute,
                              arguments: ScreenArguments(
                                  title: controller.sortedDailyClasses.keys
                                      .elementAt(index),
                                  tickets: controller.sortedDailyClasses.values
                                      .elementAt(index)),
                            );
                            
                            controller.updateClasses(
                                list as List<Ticket>, index);
                          }),
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
