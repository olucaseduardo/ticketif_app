import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_options.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/widgets/exclusion_options_modal.dart';

class CaeHomeScreen extends ConsumerStatefulWidget {
  const CaeHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CaeHomeScreen> createState() => _CaeHomeScreenState();
}

class _CaeHomeScreenState extends ConsumerState<CaeHomeScreen> {
  @override
  void initState() {
    ref.read(caeProvider).loadLink();
    super.initState();
  }

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
              Text(
                DateUtil.todayDate(DateUtil.dateTimeNow),
                style:
                    AppTextStyle.labelBig.copyWith(fontWeight: FontWeight.w700),
              ),
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

              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.admLoginRoute, (route) => false);
            },
          ),
        ],
      ),
      body: Visibility(
        visible: !controller.isLoading,

        replacement: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loader.loader(),
          ],
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    Center(
                      child: Image.asset(
                        'assets/images/CAE.png',
                        width: 207,
                      ),
                    ),
                    const SizedBox(height: 26),
                    CommonTileOptions(
                      leading: Icons.local_restaurant_rounded,
                      label: 'Tickets Diários',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.caeClassesRoute,
                        arguments: ScreenArguments(
                            isPermanent: false, title: 'Tickets Diários'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.menu_rounded,
                      label: 'Autorizações Permanentes',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.authorizationClassesRoute,
                        arguments:
                            ScreenArguments(title: 'Autorizações Permanentes'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.description_rounded,
                      label: 'Relatório Diário',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.dailyReportRoute,
                        arguments: ScreenArguments(cae: true),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.calendar_month_rounded,
                      label: 'Relatório por Período',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.caePeriodReportRoute,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.confirmation_number_rounded,
                      label: 'Solicitar Ticket',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.caeSearchStudentRoute,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.add_circle,
                      label: 'Adicionar Nova Turma (Médio)',
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.addNewClass,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: CupertinoIcons.gear_solid,
                      label: "Definições do Sistema",
                      function: () => Navigator.pushNamed(
                        context,
                        AppRouter.systemConfig
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTileOptions(
                      leading: Icons.delete,
                      label: 'Opções de Exclusão',
                      function: () => showModalBottomSheet(
                        context: context,
                        builder: (_) => ExclusionOptionsModal(controller: controller),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
