// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';

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
    final controller = ref.watch(historicProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 130),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.white,
              title: Text(
                'Voltar',
                style: TextStyle(
                    color: AppColors.gray200,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700),
              ),
              flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: 90.h, left: 20.w, right: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(title, style: AppTextStyle.largeText))
                      ])),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.gray200,
                  )),
            )),
        body: userTickets.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CommonTicketWidget(
                    ticket: userTickets.elementAt(i),
                  ),
                ),
                itemCount: userTickets.length, // controller.countOne,
                physics: const AlwaysScrollableScrollPhysics(),
              )
            : Center(
                child: Text('Sem tickets no seu $title'),
              ));
  }
}
