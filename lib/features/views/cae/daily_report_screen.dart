import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_report.dart';

class DailyReportScreen extends StatefulWidget {
  const DailyReportScreen({super.key});

  @override
  State<DailyReportScreen> createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen> {
  DateTime day = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'Data: ${DateUtil.getDateStr(day)}',
                  style: TextApp.titleLarge,
                ),
              ),
              const Divider(),
              Text("Utilizados"),
              CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 0'),
              CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 0'),
              const Divider(),
              Text("Aprovados"),
              CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 0'),
              CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 0'),
              const Divider(),
              Text("Em Análise"),
              CommonTileReport(title: 'Almoço - médio', subtitle: 'Total: 0'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var pickDate = await showDatePicker(
              context: context,
              initialDate: day,
              firstDate: day.subtract(const Duration(days: 365)),
              lastDate: day.add(const Duration(days: 365)));

          if (pickDate != null) {
            setState(() {
              day = pickDate;
            });
          }
        },
        child: const Icon(
          Icons.calendar_today,
        ),
      ),
    );
  }
}
