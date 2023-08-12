import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';

class CaeHomeScreen extends ConsumerStatefulWidget {
  const CaeHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CaeHomeScreen> createState() => _CaeHomeScreenState();
}

class _CaeHomeScreenState extends ConsumerState<CaeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateUtil.todayDate(DateUtil.dateTimeNow),
                  style: AppTextStyle.labelBig
                      .copyWith(fontWeight: FontWeight.w700)),
              const Text('Administrador', style: AppTextStyle.labelMedium)
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              controller.onLogoutTap();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/admLogin', (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Image.asset(
                      'assets/images/CAE.png',
                      width: 207,
                    ),
                  )),
                  CommonTileOptions(
                    leading: Icons.local_restaurant_rounded,
                    label: 'Tickets Diários',
                    function: () => Navigator.pushNamed(
                        context, AppRouter.caeClassesRoute,
                        arguments: ScreenArguments(
                            isPermanent: false, title: 'Tickets Diários')),
                  ),
                  CommonTileOptions(
                    leading: Icons.menu_rounded,
                    label: 'Autorizações Permanentes',
                    function: () => Navigator.pushNamed(
                        context, AppRouter.authorizationClassesRoute,
                        arguments: ScreenArguments(
                            isPermanent: true,
                            title: 'Autorizações Permanentes')),
                  ),
                  CommonTileOptions(
                    leading: Icons.description_rounded,
                    label: 'Relatório Diário',
                    function: () => Navigator.pushNamed(
                        context, AppRouter.dailyReportRoute,
                        arguments: ScreenArguments(cae: true)
                        ),
                  ),
                  CommonTileOptions(
                    leading: Icons.calendar_month_rounded,
                    label: 'Relatório por Periódo',
                    function: () => Navigator.pushNamed(
                      context,
                      AppRouter.caePeriodReportRoute,
                    ),
                  ),
                  CommonTileOptions(
                    leading: Icons.confirmation_number_rounded,
                    label: 'Solicitar Ticket',
                    function: () => Navigator.pushNamed(
                      context,
                      AppRouter.caeSearchStudentRoute,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
