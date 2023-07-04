import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_report.dart';

class PeriodReportScreen extends StatefulWidget {
  const PeriodReportScreen({super.key});

  @override
  State<PeriodReportScreen> createState() => _PeriodReportScreenState();
}

class _PeriodReportScreenState extends State<PeriodReportScreen> {
  DateTime now = DateTime.now();
  late DateTime start = DateTime.utc(now.year, now.month, 1);
  late DateTime end = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório por Período'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Column(
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
          ),
          const Divider(),
          CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 200'),
        ],
      ),
    );
  }
}
