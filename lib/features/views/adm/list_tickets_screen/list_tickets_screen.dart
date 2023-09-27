import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_ticket.dart';

class ListTicketsScreen extends StatelessWidget {
  final String title;
  final List<Ticket> tickets;
  final String description;
  final String subtitle;
  
  const ListTicketsScreen({
    super.key,
    required this.title,
    required this.tickets, 
    required this.description, 
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(subtitle, style: AppTextStyle.titleSmall,),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              description,
              style: AppTextStyle.labelBig.copyWith(color: AppColors.gray400),
            ),

            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: tickets.length,
                
                itemBuilder: (_, index) => CommonTileTicket(
                  title: tickets.elementAt(index).student,
                  subtitle: tickets.elementAt(index).studentName,
                  justification: tickets.elementAt(index).justification,
                ),
                ),
            ),
          ],
        ),
      )
    );
  }
}
