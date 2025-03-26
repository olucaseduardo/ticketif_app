import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_options.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  @override
  void initState() {
    ref.read(restaurantProvider).loadLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateUtil.todayDate(DateUtil.dateTimeNow),
                style:
                    AppTextStyle.labelBig.copyWith(fontWeight: FontWeight.w700),
              ),
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

              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.admLoginRoute, (route) => false);
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
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/Restaurant.png',
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonTileOptions(
                    leading: Icons.qr_code_scanner_rounded,
                    label: 'Validar Ticket',
                    function: () => Navigator.pushNamed(
                      context,
                      AppRouter.qrRoute,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonTileOptions(
                    leading: Icons.description_rounded,
                    label: 'Relatórios',
                    function: () => Navigator.pushNamed(
                      context,
                      AppRouter.dailyReportRoute,
                      arguments: ScreenArguments(cae: false),
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
