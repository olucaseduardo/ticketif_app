import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
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
  late DateTime start =
      DateTime.utc(DateUtil.dateTimeNow.year, DateUtil.dateTimeNow.month, 1);
  late DateTime end = DateUtil.dateTimeNow;

  @override
  void initState() {
    ref.read(periodReportProvider).loadPeriodTickets(
        initialDate: DateUtil.getDateUSStr(start),
        finalDate: DateUtil.getDateUSStr(end));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(periodReportProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.i.showError('Erro ao carregar relatório por período');
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
                        Text(
                          'De: ${DateUtil.getDateStr(start)} até: ${DateUtil.getDateStr(end)}',
                          style: AppTextStyle.titleMedium.copyWith(
                              color: AppColors.green300, fontSize: 16.sp),
                        ),

                        IconButton(
                            onPressed: () async {
                              DateTimeRange? result = await showDateRangePicker(
                                context: context,
                                initialEntryMode: DatePickerEntryMode.calendar,
                                firstDate: DateTime(
                                    2022, 1, 1), // the earliest allowable
                                lastDate: DateTime(
                                    2025, 12, 31), // the latest allowable
                                currentDate: DateUtil.dateTimeNow,
                                saveText: 'Salvar',
                              );

                              setState(() {
                                if (result != null) {
                                  start = result.start;
                                  end = result.end;
                                }
                              });

                              controller.updatePeriodTickets(start, end);
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

                    replacement: const WithoutResults(
                        msg: 'Nenhuma solicitação encontrada'),

                    child: Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var status = controller.dailyStatus.keys
                                .elementAt(index)
                                .toString();
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
                                      var valuesMeal = controller
                                          .dailyStatus[status]![keyMeal];

                                      return CommonTileReport(
                                          function: () =>
                                              Navigator.of(context).pushNamed(
                                                AppRouter.listTickets,
                                                arguments: ScreenArguments(
                                                  title: keyMeal,
                                                  subtitle: DateUtil.getDateStr(
                                                      DateTime.parse(valuesMeal
                                                          .reversed
                                                          .elementAt(0)
                                                          .useDayDate)),
                                                  description: valuesMeal
                                                      .reversed
                                                      .elementAt(0)
                                                      .status,
                                                  tickets: valuesMeal.reversed
                                                      .toList(),
                                                ),
                                              ),
                                          status: status,
                                          title: keyMeal,
                                          subtitle:
                                              'Total: ${valuesMeal!.length}');
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
          onPressed: () {
            controller.exportCSV();
          },
          child: const Icon(Icons.save_rounded),
        ));
  }
}
