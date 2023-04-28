import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                Text(DateUtil.todayDate(DateUtil.dateTime),
                    style:
                        TextApp.labelBig.copyWith(fontWeight: FontWeight.w700)),
                const Text('20191BCC.CAX0003', style: TextApp.labelMedium)
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => controller.onLogoutTap(),
              icon: const Icon(
                Icons.logout,
              ),
            ),
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
                    Flexible(
                      child: Text(
                        'Olá, Fulano de tal',
                        style: TextApp.labelBig
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    CommonButton(
                      label: 'Solicitar um ticket',
                      textPadding: 8,
                      textStyle: AppTextStyle.smallButton,
                      function: () => controller.onRequestTicketTap(),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        'Suas refeições de hoje',
                        style: TextApp.labelBig.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray200),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: CommonTicketWidget(),
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
                      child: Text(
                        'Outras opções',
                        style: TextApp.labelBig.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray200),
                      ),
                    ),
                    CommonTileOptions(
                      leading: Icons.menu_rounded,
                      label: 'Seus tickets',
                      function: () => controller.onTicketsTap(),
                    ),
                    
                    CommonTileOptions(
                      leading: Icons.access_time_rounded,
                      label: 'Histórico',
                      function: () => controller.onHistoricTap(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
