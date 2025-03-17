import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ticket_ifma/core/services/notification_service.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/alert.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_ticket_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_options.dart';
import 'package:ticket_ifma/features/resources/widgets/error_results.dart';
import 'package:ticket_ifma/features/views/home_screen/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late StreamSubscription<InternetStatus> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initNotificationService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _connectivitySubscription =
          InternetConnection().onStatusChange.listen(_updateStatusNetwork);
      bool result = await InternetConnection().hasInternetAccess;
      ref.read(homeProvider).updateStatusNetwork(result);
      ref.read(homeProvider).loadData();
    });
  }

  _initNotificationService() {
    WidgetsFlutterBinding.ensureInitialized();
    NotificationService();
  }

  _updateStatusNetwork(InternetStatus status) async {
    final controller = ref.watch(homeProvider);
    switch (status) {
      case InternetStatus.connected:
        controller.updateStatusNetwork(true);
        break;
      case InternetStatus.disconnected:
        controller.updateStatusNetwork(false);
        break;
    }
  }

  logout(HomeController controller) {
    controller.onLogoutTap().whenComplete(() => Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (route) => false));
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeProvider);

    return Scaffold(
      appBar: _buildAppBar(controller),
      body: _buildBody(controller),
    );
  }

  PreferredSizeWidget _buildAppBar(HomeController controller) {
    if (controller.isLoading || controller.error) {
      return const PreferredSize(
        preferredSize: Size(0, 0),
        child: SizedBox.shrink(),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.green[600],
      centerTitle: false,
      title: Text(DateUtil.todayDate(DateUtil.dateTimeNow)),
      toolbarHeight: 55,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(controller),
        ),
      ],
    );
  }

  Widget _buildBody(HomeController controller) {
    if (controller.isLoading) {
      return Loader.loader();
    }

    if (controller.error) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ErrorResults(
          msg: '',
          msgError:
              'Erro ao carregar seus dados, verifique sua conexão a internet',
          login: () => logout(controller),
          // reload: () {
          //   controller.loadData();
          // },
        ),
      );
    }

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildUserInfoSection(controller),
                const Divider(height: 0, indent: 0),
                _buildMealsSection(controller),
                _buildOtherOptionsSection(controller),
              ],
            ),
            const SizedBox(height: 10,),
            _buildFeedbackSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRouter.photoStudentRoute);
                      },
                      child: Stack(
                        children: _buildStudentImageCache(controller),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Olá, ${controller.user?.username ?? 'Usuário'}',
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: AppTextStyle.labelBig
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      controller.user?.registration ?? '',
                      style: AppTextStyle.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              _buildOnlineStatus(controller),
              const SizedBox(height: 0),
              CommonButton(
                label: 'Solicitar ticket',
                size: ButtonSize.small,
                textPadding: 8,
                function: () => controller.isOnline
                    ? Navigator.pushNamed(
                        context,
                        AppRouter.requestTicketRoute,
                        arguments: ScreenArguments(
                          orderDinner: controller.orderDinner,
                          orderLunch: controller.orderLunch,
                        ),
                      )
                    : AppMessage.i.showInfo(
                        "A solicitação só pode ser realizada quando conectado a internet"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineStatus(HomeController controller) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color:
                controller.isOnline ? AppColors.green[300]! : Colors.redAccent),
      ),
      child: Row(
        children: [
          Text(
            "Você está ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: controller.isOnline
                  ? AppColors.green[500]!
                  : Colors.redAccent,
            ),
          ),
          Text(
            controller.isOnline ? "Online" : "Offline",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: controller.isOnline
                  ? AppColors.green[500]!
                  : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suas refeições de hoje',
                  style: AppTextStyle.labelBig
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () => controller.isOnline
                      ? controller
                          .reloadData(controller.user?.registration ?? '')
                      : AppMessage.i.showInfo(
                          "Conecte-se a internet para realizar esta operação"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 0.0),
                    ),
                  ),
                  child: Text(
                    'Atualizar',
                    style: AppTextStyle.titleSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.isReloading == false,
            replacement: SizedBox(height: 100, child: Loader.refreshLoader()),
            child: controller.todayTicketsMap?.isNotEmpty ?? false
                ? Column(
                    children: [
                      const SizedBox(height: 5),
                      Column(
                        children: controller.todayTicketsMap!.entries
                            .map((entry) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: CommonTicketWidget(
                                    ticket: entry.value.first,
                                    function: () => controller.changeTicket(
                                      entry.value.first.id,
                                      entry.value.first.idStatus,
                                      entry.value.first.idMeal,
                                    ),
                                  ),
                                ))
                            .toList(),
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
                              fontSize: 12, color: AppColors.gray[800]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherOptionsSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Outras opções',
              style:
                  AppTextStyle.labelBig.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          CommonTileOptions(
            leading: Icons.access_time_rounded,
            label: 'Histórico',
            function: () => Navigator.pushNamed(
              context,
              AppRouter.historicRoute,
              arguments: ScreenArguments(tickets: controller.userTickets ?? []),
            ),
          ),
          const SizedBox(height: 8),
          CommonTileOptions(
            leading: Icons.menu_rounded,
            label: 'Autorizações Permanentes',
            function: () => Navigator.pushNamed(
              context,
              AppRouter.permanentsRoute,
              arguments:
                  ScreenArguments(permanents: controller.permanents ?? []),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Alert(
        icon:
            const Icon(PhosphorIconsFill.star, color: AppColors.blue, size: 16),
        title: Text('Avalie-nos!',
            style: AppTextStyle.titleMedium
                .copyWith(fontWeight: FontWeight.w700, color: AppColors.blue)),
        subtitle: RichText(
          text: TextSpan(
            text: 'Ajude-nos a melhorar! ',
            style: AppTextStyle.bodyMedium.copyWith(color: AppColors.gray[800]),
            children: [
              TextSpan(
                text: 'Clique aqui',
                style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.blue, fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse('https://forms.gle/65pGTHpxd6FQPSmT7'),
                        mode: LaunchMode.externalApplication);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStudentImageCache(HomeController controller) {
    if (controller.imageUrl != null) {
      return [
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              key: UniqueKey(),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              cacheKey: "student_photo_${controller.user?.registration}",
              imageUrl: controller.imageUrl ?? '',
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.gray[200]),
                width: 100,
                height: 100,
                child: Loader.refreshLoader(),
              ),
              errorWidget: (context, url, error) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.gray[200]),
                width: 100,
                height: 100,
                child:
                    const Icon(Icons.person, size: 50, color: AppColors.gray),
              ),
            )),
        Positioned(
          left: 70,
          child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.gray[25]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white),
              child: const Icon(
                size: 20,
                Icons.edit,
                color: AppColors.gray,
              )),
        ),
      ];
    }

    return [
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.gray[200],
            borderRadius: BorderRadius.circular(50)),
        width: 100,
        height: 100,
        child: const Icon(Icons.person, size: 50, color: AppColors.gray),
      ),
      Positioned(
        left: 70,
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray[300]!),
                borderRadius: BorderRadius.circular(15),
                color: AppColors.gray[200]),
            child: const Icon(
              size: 20,
              Icons.edit,
              color: AppColors.gray,
            )),
      ),
    ];
  }
}
