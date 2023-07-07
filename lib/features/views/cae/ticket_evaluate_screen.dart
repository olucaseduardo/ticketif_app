import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_ticket.dart';

class TicketEvaluateScreen extends ConsumerStatefulWidget {
  final List<Ticket> tickets;
  const TicketEvaluateScreen({
    super.key,
    required this.tickets,
  });

  @override
  ConsumerState<TicketEvaluateScreen> createState() =>
      _TicketEvaluateScreenState();
}

class _TicketEvaluateScreenState extends ConsumerState<TicketEvaluateScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(caeProvider).filtered.clear();
    ref.read(caeProvider).filtered.addAll(widget.tickets);
    ref.read(caeProvider).selected.addAll(widget.tickets);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    List<Ticket> allTickets = widget.tickets;

    bool continueSolicitation() {
      if (controller.selected.isEmpty) {
        AppMessage.showInfo('Não existem tickets selecionados!');
        return false;
      }

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Turma 20231A.CAX'),
        actions: [
          IconButton(
            onPressed: () {
              if (controller.isLoading) return;
              controller.isSelected(widget.tickets);
            },
            icon: Icon(controller.selectAll
                ? Icons.check_box
                : Icons.check_box_outline_blank),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Visibility(
          visible: !controller.isLoading,

          replacement: Loader.loader(),

          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.filterTickets(value, allTickets),
                decoration: const InputDecoration(
                  fillColor: AppColors.gray800,
                  filled: true,
                  hintText: "Busca",
                  prefixIcon: Icon(Icons.search, color: AppColors.green500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
        
              Visibility(
                visible: controller.filtered.isNotEmpty,
                replacement: const Expanded(
                  child: Center(
                    child: Text('Nenhuma solicitação encontrada',
                        style: AppTextStyle.normalText),
                  ),
                ),
                
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller.filtered.length,
                    itemBuilder: (context, index) => CommonTileTicket(
                        title: controller.filtered.elementAt(index).student,
                        subtitle:
                            "${controller.filtered.elementAt(index).meal} : ${DateUtil.getDateStr(DateTime.parse(controller.filtered.elementAt(index).useDayDate))}",
                        justification:
                            controller.filtered.elementAt(index).justification,
                        selected: controller.selectAll,
                        function: () => controller
                            .verifySelected(controller.filtered[index])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  if (continueSolicitation()) {
                    controller.solicitation(7);
                  }
                },
                child: const Text(
                  'Recusar',
                  // style: Style.buttonTextStyle,
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),
            // Style.formSizedBox,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (continueSolicitation()) {
                    controller.solicitation(2);
                  }
                },
                child: const Text(
                  'Aprovar',
                  // style: Style.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
