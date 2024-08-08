import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_ticket_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_options.dart';
import 'package:ticket_ifma/features/resources/widgets/error_results.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(homeProvider).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeProvider);
    final todayTicket = controller.todayTicket;

    return Scaffold(
      appBar: !controller.isLoading && !controller.error
          ? AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(
                DateUtil.todayDate(DateUtil.dateTimeNow),
                style: AppTextStyle.labelBig,
              ),
              toolbarHeight: 50,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                  ),
                  onPressed: () {
                    controller.onLogoutTap();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                ),
              ],
            )
          : const PreferredSize(
              preferredSize: Size(0, 0),
              child: SizedBox.shrink(),
            ),
      body: Visibility(
        visible: !controller.isLoading,
        replacement: Loader.loader(),
        child: Visibility(
          visible: !controller.error,
          replacement: ErrorResults(
            msg: 'Voltar ao login',
            msgError: 'Erro ao carregar usuário',
            function: () => controller.onLogoutTap(),
            homeStudent: true,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, ${controller.user?.username ?? ''}',
                              overflow: TextOverflow.visible,
                              maxLines: null,
                              style: AppTextStyle.labelBig
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              controller.user?.matricula ?? '',
                              style: AppTextStyle.labelMedium,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      CommonButton(
                        label: 'Solicitar ticket',
                        textPadding: 8,
                        textStyle: AppTextStyle.smallButton,
                        function: () => controller.checkingRequestBlocking()
                            ? Navigator.pushNamed(
                                context, AppRouter.requestTicketRoute)
                            : AppMessage.i.showInfo(
                                'Você já possui um ticket para ${todayTicket?.meal.toLowerCase()}'),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  indent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [
                            Text(
                              'Suas refeições de hoje',
                              style: AppTextStyle.labelBig.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            TextButton(
                              onPressed: () => controller.reloadData(controller.user!.id),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty
                                  .all<Color>(Colors.white),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                    horizontal: 0.0, 
                                    vertical: 0.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Atualizar',
                                style: AppTextStyle.titleSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Visibility(
                        visible: controller.isReloading == false,

                        replacement: SizedBox(
                          height: 100,
                          child: Loader.refreshLoader(),
                        ),

                        child: controller.todayTicketsMap!.isNotEmpty
                        ? Column(
                          children: [
                            const SizedBox(height: 8),
                        
                            Column(
                              children: controller.todayTicketsMap!.entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: CommonTicketWidget(
                                      ticket: entry.value.first,
                                      function: () => controller.changeTicket(
                                        entry.value.first.id,
                                        entry.value.first.idStatus,
                                        entry.value.first.idMeal,
                                      ),
                                    ),
                                  )
                              ).toList(),
                            ),
                            const SizedBox(height: 14),
                          ],
                        ) 
                        : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                'Nenhum ticket, faça sua solicitação e aguarde ser aprovado.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.gray[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Outras opções',
                          style: AppTextStyle.labelBig.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTileOptions(
                        leading: Icons.access_time_rounded,
                        label: 'Histórico',
                        function: () => Navigator.pushNamed(
                          context,
                          AppRouter.historicRoute,
                          arguments: ScreenArguments(
                            tickets: controller.userTickets,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTileOptions(
                        leading: Icons.menu_rounded,
                        label: 'Autorizações Permanentes',
                        function: () => Navigator.pushNamed(
                          context,
                          AppRouter.permanentsRoute,
                          arguments: ScreenArguments(
                            permanents: controller.permanents,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
