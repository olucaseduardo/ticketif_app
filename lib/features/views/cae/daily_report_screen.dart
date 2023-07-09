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

class DailyReportScreen extends ConsumerStatefulWidget {
  const DailyReportScreen({super.key});

  @override
  ConsumerState<DailyReportScreen> createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends ConsumerState<DailyReportScreen> {
  @override
  void initState() {
    ref.read(reportProvider)
        .loadDailyTickets(date: DateUtil.getDateUSStr(DateUtil.dateTime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(reportProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.showError('Erro ao carregar relatório diário');
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório diário'),
      ),

      body: Visibility(
        visible: !controller.isLoading,
          
        replacement: Loader.loader(),

        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Visibility(
            visible: !controller.error,

            replacement: const ErrorResults(
              msg: 'Voltar para a tela de início',
              msgError: 'Erro ao carregar relatório diário',
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data: ${DateUtil.getDateStr(controller.day)}',
                        style: AppTextStyle.titleLarge,
                      ),
                      IconButton(
                          onPressed: () async {
                            var pickDate = await showDatePicker(
                                context: context,
                                initialDate: controller.day,
                                firstDate: controller.day
                                    .subtract(const Duration(days: 365)),
                                lastDate:
                                    controller.day.add(const Duration(days: 365)));
                          
                            controller.updateDate(pickDate);
                          },
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: AppColors.green300,
                          ))
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
                              Text(controller.dailyStatus.keys.elementAt(index)),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
