import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_report.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Relatório por Período'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          style: TextApp.titleLarge,
                        ),
                        Text(
                          'Final: ${DateUtil.getDateStr(end)}',
                          style: TextApp.titleLarge,
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
                        },
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.green300,
                        ))
                  ],
                ),
              ),
              const Divider(),
              const CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 200'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_rounded),
        ));
  }
}
