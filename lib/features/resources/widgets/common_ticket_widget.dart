
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/dialog.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/core/utils/path_image.dart' as path_image;
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/views/historic_screen/historic_controller.dart';

class CommonTicketWidget extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? function;
  final HistoricController? controller;
  final bool isTap;

  const CommonTicketWidget({
    super.key,
    required this.ticket,
    this.function,
    this.controller,
    this.isTap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateUtil.ticketDay(
                      DateTime.parse(ticket.useDayDate),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            size: 12,
                            color: AppColors.gray[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ticket.meal,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ticket.statusImage(),
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                ticket.status,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isTap)
            SizedBox(
              width: 120,
              height: 100,
              child: Material(
                color: Colors.transparent,
                child: actionWidget(
                  ticket.idStatus,
                  ticket.statusImage(),
                  function,
                  ticket,
                  context,
                  controller,
                ),
              ),
            )
        ],
      ),
    );
  }
}

DateTime _today() {
  DateTime dayNow = DateTime.now();
  DateTime todayOnlyDate = DateTime(dayNow.year, dayNow.month, dayNow.day);

  return todayOnlyDate;
}

DateTime _convertStringToDateTime(String ticketUseDayDate) {
  DateTime dateTime = DateTime.parse(ticketUseDayDate);
  DateTime dateTimeOnlyDate =
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  return dateTimeOnlyDate;
}

bool _checkTodayAction(String ticketUseDayDate) {
  DateTime dateTime = _convertStringToDateTime(ticketUseDayDate);
  DateTime today = _today();
  return dateTime == today;
}

Widget actionWidget(int idStatus, String statusImage, VoidCallback? action,
    Ticket ticket, BuildContext context, HistoricController? controller) {
  if (idStatus == 1 && _checkTodayAction(ticket.useDayDate)) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogForm(
            title: 'Cancelar Ticket?',
            action: controller == null
                ? () => action!()
                : () => controller.cancelTicket(ticket.id),
            colorConfirmButton: AppColors.red,
            confirmButtonTextStyle: AppTextStyle.titleMedium.copyWith(
              color: AppColors.white,
            ),
            message:
                "Caso você não irá utilizar este ticket, clique em sim para cancelar sua solicitação.",
          ),
        );
      },
      child: const Row(
        children: [
          DottedLine(
            direction: Axis.vertical,
            lineLength: 60,
            dashLength: 2,
            dashColor: AppColors.gray,
          ),
          Expanded(
            child: Align(
                child: Text(
              'Cancelar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.red,
                letterSpacing: -1,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            )),
          ),
        ],
      ),
    );
  } else if (idStatus == 2 && _checkTodayAction(ticket.useDayDate)) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogForm(
            title: 'Confirmar Presença?',
            action: controller == null
                ? () => action!()
                : () => controller.confirmTicket(ticket.id, ticket.idMeal),
            labelConfirmButton: "Confirmar",
            message:
                "Caso você irá utilizar este ticket, clique em confirmar para validar sua presença.",
          ),
        );
      },
      child: const Row(
        children: [
          DottedLine(
            direction: Axis.vertical,
            lineLength: 60,
            dashLength: 2,
            dashColor: AppColors.gray,
          ),
          Expanded(
            child: Align(
              child: Text(
                'Confirmar\nPresença',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    fontSize: 16,
                    height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (idStatus == 4 && _checkTodayAction(ticket.useDayDate)) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.useTicketQrCodeScreen,
            arguments: ScreenArguments(ticket: ticket));
      },
      child: Row(
        children: [
          const DottedLine(
            direction: Axis.vertical,
            lineLength: 60,
            dashLength: 2,
            dashColor: AppColors.gray,
          ),
          Expanded(
            child: Align(
              child: SvgPicture.asset(
                path_image.qrUse,
                height: 50,
                width: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // else if (idStatus == 5) {
  //   return const Icon(
  //     Icons.check_circle_rounded,
  //     size: 50,
  //     color: AppColors.green,
  //   );
  // } else if (idStatus == 6) {
  //   return Icon(
  //     Icons.cancel_rounded,
  //     size: 50.r,
  //     color: AppColors.red,
  //   );
  // } else if (idStatus == 7) {
  //   return Icon(
  //     Icons.error,
  //     size: 50.r,
  //     color: AppColors.yellow,
  //   );
  // }
  return const SizedBox(
    height: 50,
    width: 50,
  );
}
// 'Café da manhã',
// 'Utilização autorizada'