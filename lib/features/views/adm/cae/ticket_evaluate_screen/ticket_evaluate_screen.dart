import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_ticket.dart';
import 'package:ticket_ifma/features/resources/widgets/without_results.dart';

class TicketEvaluateScreen extends ConsumerStatefulWidget {
  final List<Ticket> tickets;
  final String title;
  const TicketEvaluateScreen({
    super.key,
    required this.title,
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
    log(widget.tickets.toString());
    ref.read(ticketEvaluateProvider).filteredTickets.addAll(widget.tickets);
    ref.read(ticketEvaluateProvider).selectedTickets.addAll(widget.tickets);
    ref.read(ticketEvaluateProvider).selectAll = true;
    ref.read(ticketEvaluateProvider).isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ticketEvaluateProvider);
    List<Ticket> allTickets = widget.tickets;
    final lengthTickets = allTickets.length;

    log('Selected ${controller.selectedTickets.length.toString()}');
    log('SelectedAll ${controller.selectAll.toString()}');

    bool continueSolicitation() {
      if (controller.selectedTickets.isEmpty) {
        AppMessage.i.showInfo('Não existem tickets selecionados!');
        return false;
      }

      return true;
    }

    return PopScope(
      canPop: true,

      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Navigator.pop(context, controller.filteredTickets);
      },
      
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, controller.filteredTickets);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(widget.title),
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
                  onChanged: (value) =>
                      controller.filterTickets(value, allTickets),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: controller.filteredTickets.isNotEmpty,
                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredTickets.length,
                      itemBuilder: (context, index) => CommonTileTicket(
                        title:
                            controller.filteredTickets.elementAt(index).student,
                        subtitle:
                            "${controller.filteredTickets.elementAt(index).meal}: ${DateUtil.getDateStr(DateTime.parse(controller.filteredTickets.elementAt(index).useDayDate))}",
                        justification: controller.filteredTickets
                            .elementAt(index)
                            .justification,
                        selected: controller.selectedTickets
                                .contains(controller.filteredTickets[index])
                            ? true
                            : false,
                        function: () => controller.verifySelected(
                            controller.filteredTickets[index], lengthTickets),
                        check: true,
                      ),
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
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (continueSolicitation()) {
                      controller.solicitation(2);
                    }
                  },
                  child: const Text(
                    'Aprovar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
