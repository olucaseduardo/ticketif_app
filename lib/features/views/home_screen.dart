import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';
import 'package:project_ifma_ticket/features/views/historic_screen.dart';
import 'package:project_ifma_ticket/features/views/request_ticket_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(homeProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateUtil.todayDate(dateTime),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const Text(
                  '20191BCC.CAX0003',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => controller.onLogoutTap(),
                icon: const Icon(
                  Icons.logout,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text('Olá, Fulano de tal',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray200)),
                    ),
                    CommomButton(
                      label: 'Solicitar um ticket',
                      textPadding: 8,
                      textStyle: AppTextStyle.smallButton,
                      onPressed: () => controller.onRequestTicketTap(),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1.5,
                color: AppColors.gray800,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: Text('Suas refeições de hoje',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray200)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: const CommomTicketWidget(),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 20.h),
                    //   child: Align(
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //           'Nenhum ticket, faça sua solicitação e aguarde ser aprovado',
                    //           style: TextStyle(
                    //               fontSize: 12.sp, color: AppColors.gray700))),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.h),
                      child: const Text('Outras opções',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray200)),
                    ),
                    CommonTileOptions(
                      leading: Icons.menu_rounded,
                      label: 'Seus tickets',
                      onTap: () => controller.onTicketsTap(),
                    ),
                    CommonTileOptions(
                      leading: Icons.search_rounded,
                      label: 'Tickets em análise',
                      onTap: () => controller.onAnalysisTap(),
                    ),
                    CommonTileOptions(
                      leading: Icons.access_time_rounded,
                      label: 'Histórico',
                      onTap: () => controller.onHistoricTap(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
