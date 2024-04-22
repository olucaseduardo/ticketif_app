import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:TicketIFMA/core/services/providers.dart';
import 'package:TicketIFMA/core/utils/date_util.dart';
import 'package:TicketIFMA/core/utils/loader.dart';
import 'package:TicketIFMA/features/resources/routes/app_routes.dart';
import 'package:TicketIFMA/features/resources/routes/screen_arguments.dart';
import 'package:TicketIFMA/features/resources/theme/app_text_styles.dart';
import 'package:TicketIFMA/features/resources/widgets/app_message.dart';
import 'package:TicketIFMA/features/resources/widgets/common_tile_report.dart';
import 'package:TicketIFMA/features/resources/widgets/error_results.dart';
import 'package:TicketIFMA/features/resources/widgets/without_results.dart';

class DailyReportScreen extends ConsumerStatefulWidget {
  final bool? cae;
  const DailyReportScreen({super.key, this.cae = true});

  @override
  ConsumerState<DailyReportScreen> createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends ConsumerState<DailyReportScreen> {
  @override
  void initState() {
    ref.read(reportProvider).loadDailyTickets(
        date: DateUtil.getDateUSStr(DateUtil.dateTimeNow),
        cae: widget.cae as bool);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(reportProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.i.showError('Erro ao carregar relatório diário');
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
                        style:
                            AppTextStyle.titleMedium.copyWith(fontSize: 16.sp),
                      ),
                      IconButton(
                          onPressed: () async {
                            var pickDate = await showDatePicker(
                              context: context,
                              initialDate: controller.day,
                              firstDate: controller.day
                                  .subtract(const Duration(days: 365)),
                              lastDate: controller.day.add(
                                const Duration(days: 365),
                              ),
                            );

                            controller.updateDate(
                                pickDate: pickDate, cae: widget.cae as bool);
                          },
                          icon: const Icon(
                            Icons.edit,
                          ))
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  controller.dailyStatus.keys.elementAt(index),
                                  style: AppTextStyle.normalText,
                                ),
                              ),
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
                                                description: valuesMeal.reversed
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
