import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_ticket.dart';

class TicketEvaluateScreen extends ConsumerStatefulWidget {
  final List<Ticket> tickets;
  const TicketEvaluateScreen( {super.key,required this.tickets,});

  @override
  ConsumerState<TicketEvaluateScreen> createState() =>
      _TicketEvaluateScreenState();
}

class _TicketEvaluateScreenState extends ConsumerState<TicketEvaluateScreen> {
  late bool selectAll;
  bool loading = false;
  List<Ticket> tickets = []; 
  

  @override
  void initState() {
    super.initState();
    selectAll = true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    List<Ticket> allTickets = widget.tickets;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turma 20231A.CAX'),
        actions: [
          IconButton(
            onPressed: () {
              if (loading) return;
              // selected.clear();
              setState(() {
                selectAll = !selectAll;
                if (selectAll) {
                  // selected.addAll(widget.tickets);
                }
              });
            },
            icon: Icon(
                selectAll ? Icons.check_box : Icons.check_box_outline_blank),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
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
            Expanded(
              child: ListView.builder(
                itemCount: allTickets.length,
                itemBuilder: (context, index) => CommonTileTicket(
                    title: allTickets.elementAt(index).student,
                    subtitle:
                        "${allTickets.elementAt(index).meal} : ${DateUtil.getDateStr(DateTime.parse(allTickets.elementAt(index).useDayDate))}",
                    justification: allTickets.elementAt(index).justification),
              ),
            ),
          
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
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
                  // controller.changeTicketCAE(, status)
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
