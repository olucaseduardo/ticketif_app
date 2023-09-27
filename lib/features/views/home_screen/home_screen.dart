import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';
import 'package:project_ifma_ticket/features/resources/widgets/error_results.dart';

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

              title: Padding(
                padding: const EdgeInsets.all(8),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(DateUtil.todayDate(DateUtil.dateTimeNow),
                        style: AppTextStyle.labelBig
                            .copyWith(fontWeight: FontWeight.w700)),

                    Text(controller.user?.matricula ?? '',
                        style: AppTextStyle.labelMedium)
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
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                ),
              ],
            )
          : const PreferredSize(
              preferredSize: Size(0, 0), child: SizedBox.shrink()),
              
      body: Visibility(
        visible: !controller.isLoading,
        replacement: Loader.loader(),

        child: Visibility(
            visible: !controller.error,
            replacement: ErrorResults(
              msg: 'Voltar ao login',
              msgError: 'Erro ao carregar usuario',
              function: () => controller.onLogoutTap(),
              homeStudent: true,
            ),

            child: SingleChildScrollView(
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
                            'Olá, ${controller.user?.username?? ''}',
                            style: AppTextStyle.labelBig
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),

                        CommonButton(
                          label: 'Solicitar um ticket',
                          textPadding: 8,
                          textStyle: AppTextStyle.smallButton,
                          function: () => todayTicket?.idStatus == 7 ||
                                  todayTicket?.idStatus == 6 ||
                                  todayTicket?.idStatus == 5 ||
                                  todayTicket == null
                              ? Navigator.pushNamed(
                                  context, AppRouter.requestTicketRoute)
                              : AppMessage.i.showInfo(
                                  'Você já possui um ticket para ${todayTicket.meal.toLowerCase()}'),
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
                            style: AppTextStyle.labelBig.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.gray200),
                          ),
                        ),

                        controller.todayTickets!.isNotEmpty 
                          && todayTicket != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),

                                child: CommonTicketWidget(
                                  ticket: todayTicket,
                                  function: () => controller.changeTicket(
                                      todayTicket.id, todayTicket.idStatus),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),

                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        'Nenhum ticket, faça sua solicitação e aguarde ser aprovado',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.gray400))),
                              ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 18.h),

                          child: Text(
                            'Outras opções',
                            style: AppTextStyle.labelBig.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.gray200),
                          ),
                        ),
                        
                        CommonTileOptions(
                          leading: Icons.menu_rounded,
                          label: 'Seus tickets',

                          function: () => Navigator.pushNamed(
                            context,
                            AppRouter.historicRoute,
                            arguments: ScreenArguments(
                              title: 'Seus tickets',
                              tickets: controller.userTickets
                                  ?.where((a) => a.status != 'Cancelado')
                                  .toList(),
                            ),
                          ),
                        ),

                        CommonTileOptions(
                          leading: Icons.access_time_rounded,
                          label: 'Histórico',
                          
                          function: () => Navigator.pushNamed(
                            context,
                            AppRouter.historicRoute,
                            arguments: ScreenArguments(
                              title: 'Histórico',
                              tickets: controller.userTickets,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
