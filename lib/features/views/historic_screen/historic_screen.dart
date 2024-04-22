import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_ticket_widget.dart';

class HistoricScreen extends ConsumerWidget {
  final String title;
  final List<Ticket> userTickets;

  const HistoricScreen({
    super.key,
    required this.title,
    required this.userTickets,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 120),
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
              padding: EdgeInsets.only(top: 90.h, left: 20.w, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTextStyle.largeText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
      body: userTickets.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(top: 14),
              itemCount: userTickets.length, // controller.countOne,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CommonTicketWidget(
                      ticket: userTickets.elementAt(i),
                      isTap: title == 'Histórico' ? false : true,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(title == 'Histórico'
                  ? 'Sem tickets no seu $title'
                  : 'Sem tickets no momento'),
            ),
    );
  }
}
