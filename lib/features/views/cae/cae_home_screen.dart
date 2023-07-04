import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';

class CaeHomeScreen extends ConsumerStatefulWidget {
  const CaeHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CaeHomeScreen> createState() => _CaeHomeScreenState();
}

class _CaeHomeScreenState extends ConsumerState<CaeHomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                Text('Administrador', style: TextApp.labelMedium)
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
        body: true
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Flexible(
                    //         child: Text(
                    //           'CAE IFMA',
                    //           style: TextApp.labelBig
                    //               .copyWith(fontWeight: FontWeight.w700),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Divider(
                    //   height: 1,
                    //   thickness: 1.5,
                    //   color: AppColors.gray800,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Image.asset('assets/images/CAE.png'),
                          )),
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 18.h),
                          //   child: Text(
                          //     'Outras opções',
                          //     style: TextApp.labelBig.copyWith(
                          //         fontWeight: FontWeight.w700,
                          //         color: AppColors.gray200),
                          //   ),
                          // ),
                          CommonTileOptions(
                            leading: Icons.local_restaurant_rounded,
                            label: 'Tickets Diários',
                            function: () => Navigator.pushNamed(
                              context,
                              AppRouter.caeClassesRoute,
                            ),
                          ),
                          CommonTileOptions(
                            leading: Icons.menu_rounded,
                            label: 'Autorizações Permanentes',
                            function: () => Navigator.pushNamed(
                              context,
                              AppRouter.historicRoute,
                            ),
                          ),
                          CommonTileOptions(
                            leading: Icons.description_rounded,
                            label: 'Relatório Diário',
                            function: () => Navigator.pushNamed(
                              context,
                              AppRouter.historicRoute,
                            ),
                          ),
                          CommonTileOptions(
                            leading: Icons.calendar_month_rounded,
                            label: 'Relatório por periódo',
                            function: () => Navigator.pushNamed(
                              context,
                              AppRouter.historicRoute,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/alert.png'),
                    const Text(
                      'Erro ao carregar usuario',
                      style: AppTextStyle.normalText,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          AppMessage.showError('Erro ao carregar usuario');
                          // controller.onLogoutTap();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        },
                        child: Text(
                          'Voltar ao login',
                          style: AppTextStyle.largeText
                              .copyWith(color: AppColors.green500),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
