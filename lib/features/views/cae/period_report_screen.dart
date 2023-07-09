import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_report.dart';
import 'package:project_ifma_ticket/features/resources/widgets/error_results.dart';
import 'package:project_ifma_ticket/features/resources/widgets/without_results.dart';

class PeriodReportScreen extends ConsumerStatefulWidget {
  const PeriodReportScreen({super.key});

  @override
  ConsumerState<PeriodReportScreen> createState() => _PeriodReportScreenState();
}

class _PeriodReportScreenState extends ConsumerState<PeriodReportScreen> {
  DateTime now = DateTime.now();
  late DateTime start = DateTime.utc(now.year, now.month, 1);
  late DateTime end = DateTime.now();

   @override
  void initState() {
    ref.read(reportProvider).loadPeriodTickets(initialDate: DateUtil.getDateUSStr(start), finalDate: DateUtil.getDateUSStr(end));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(reportProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.showError('Erro ao carregar relatório por período');
      });
    }
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Relatório por Período'),
        ),
        body: Visibility(
          visible: !controller.isLoading,
          
          replacement: Loader.loader(),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Visibility(
              visible: !controller.error,

              replacement: const ErrorResults(
                msg: 'Voltar para a tela de início',
                msgError: 'Erro ao carregar relatório por período',
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Início: ${DateUtil.getDateStr(start)}',
                              style: AppTextStyle.titleLarge,
                            ),
                            Text(
                              'Final: ${DateUtil.getDateStr(end)}',
                              style: AppTextStyle.titleLarge,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTimeRange? result = await showDateRangePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.calendar,
                              firstDate:
                                  DateTime(2022, 1, 1), // the earliest allowable
                              lastDate:
                                  DateTime(2025, 12, 31), // the latest allowable
                              currentDate: DateTime.now(),
                              saveText: 'Salvar',
                            );
                            setState(() {
                              if (result != null) {
                                start = result.start;
                                end = result.end;
                              }
                            });

                            controller.updatePeriodDate(start, end);
                          },
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.green300,
                          )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.dailyStatus.isNotEmpty,
                      
                    replacement: const WithoutResults(msg: 'Nenhuma solicitação encontrada'),
                    
                    child: Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var status =
                                controller.dailyStatus.keys.elementAt(index).toString();
                            var meal = controller.dailyStatus[status]!.keys;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: meal.length,
                                    itemBuilder: (context, indexMeal) {
                                      var keyMeal = meal.elementAt(indexMeal);
                                      var valuesMeal =
                                          controller.dailyStatus[status]![keyMeal];
                                      return CommonTileReport(
                                          title: keyMeal,
                                          subtitle: 'Total: ${valuesMeal!.length}');
                                    })
                              ],
                            );
                          },
                          itemCount: controller.dailyStatus.keys.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_rounded),
        ));
  }
}
