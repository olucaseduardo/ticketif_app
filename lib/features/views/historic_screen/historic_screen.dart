
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_dropdown_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_ticket_widget.dart';

class HistoricScreen extends ConsumerStatefulWidget {
  final List<Ticket> userTickets;

  const HistoricScreen({
    super.key,
    required this.userTickets,
  });

  @override
  ConsumerState<HistoricScreen> createState() => _HistoricScreenState();
}


class _HistoricScreenState extends ConsumerState<HistoricScreen>{
  @override
  void initState() {
    ref.read(historicProvider).loadData(widget.userTickets);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final controller = ref.watch(historicProvider);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 108),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            centerTitle: false,
            title: const Text(
              'Voltar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 94, left: 16, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Histórico",
                      style: AppTextStyle.largeText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20,)
                ],
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.black,
                )),
          )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data',
                          style: AppTextStyle.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                            onTap: () async{
                              var pickDate = await showDatePicker(
                                context: context,
                                 initialDate: controller.changeDate,
                                 firstDate: controller.changeDate.subtract(const Duration(days: 365)),
                                lastDate: controller.changeDate.add(
                                  const Duration(days: 365),
                                ),
                              );
                              controller.updateDate(pickDate);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.gray[300]!,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.day == null ? 'Selecione a data' : DateUtil.getDateStr(controller.changeDate),
                                    style: TextStyle(
                                      color: AppColors.gray[700],
                                    ),
                                  ),
                                  Icon(
                                    Icons.date_range,
                                    color: AppColors.gray[700],
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status',
                          style: AppTextStyle.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 42,
                          child: CommonDropDownButton(
                            items: controller.status.entries.map((e) => e.value).toList(),
                            onChanged: (value) => controller.onStatusChanged(value),
                            isDense: true,
                            hint: controller.statusValue,
                            value: controller.statusValue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (controller.historicTickets.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 14),
                  itemCount: controller.historicTickets.length, // controller.countOne,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CommonTicketWidget(
                          ticket: controller.historicTickets.elementAt(i),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Center(
                child: Text('Sem tickets no seu histórico'),
              ),
          ],
        ),
      ),
    );
  }
}
