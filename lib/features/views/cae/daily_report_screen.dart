import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_report.dart';

class DailyReportScreen extends ConsumerStatefulWidget {
  const DailyReportScreen({super.key});

  @override
  ConsumerState<DailyReportScreen> createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends ConsumerState<DailyReportScreen> {
  DateTime day = DateTime.now();
  @override
  void initState() {
    ref
        .read(reportProvider)
        .loadDailyTickets(date: DateUtil.getDateUSStr(DateUtil.dateTime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(reportProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório diário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data: ${DateUtil.getDateStr(day)}',
                      style: AppTextStyle.titleLarge,
                    ),
                    IconButton(
                        onPressed: () async {
                          var pickDate = await showDatePicker(
                              context: context,
                              initialDate: day,
                              firstDate:
                                  day.subtract(const Duration(days: 365)),
                              lastDate: day.add(const Duration(days: 365)));

                          if (pickDate != null) {
                            setState(() {
                              day = pickDate;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.green300,
                        ))
                  ],
                ),
              ),
              const Divider(),
              const Text("Utilizados"),
              const CommonTileReport(
                  title: 'Almoço - médio', subtitle: 'Total: 0'),
              const CommonTileReport(
                  title: 'Almoço - médio', subtitle: 'Total: 0'),
              const Divider(),
              const Text("Aprovados"),
              const CommonTileReport(
                  title: 'Almoço - médio', subtitle: 'Total: 0'),
              const CommonTileReport(
                  title: 'Almoço - médio', subtitle: 'Total: 0'),
              const Divider(),
              const Text("Em Análise"),
              const CommonTileReport(
                  title: 'Almoço - médio', subtitle: 'Total: 0'),
            ],
          ),
        ),
      ),
    );
  }
}
