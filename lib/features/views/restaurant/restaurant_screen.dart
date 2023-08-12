import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
              const Text('Restaurante', style: AppTextStyle.labelMedium)
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
                      'assets/images/Restaurant.png',
                    ),
                  )),
                  CommonTileOptions(
                    leading: Icons.qr_code_scanner_rounded,
                    label: 'Validar Ticket',
                    function: () => Navigator.pushNamed(
                      context,
                      AppRouter.qrRoute,
                    ),
                  ),
                  CommonTileOptions(
                    leading: Icons.description_rounded,
                    label: 'Relatórios',
                    function: () => Navigator.pushNamed(
                        context, AppRouter.dailyReportRoute,
                        arguments: ScreenArguments(cae: false)),
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
