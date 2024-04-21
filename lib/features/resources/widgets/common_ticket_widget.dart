import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/dialog.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/core/utils/path_image.dart' as path_image;
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_dialog.dart';

class CommonTicketWidget extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? function;
  final bool isTap;

  const CommonTicketWidget(
      {Key? key, required this.ticket, this.function, this.isTap = true})
      : super(key: key);

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
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
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
                          SizedBox(width: 4.w),
                          Text(
                            ticket.meal,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16.w,
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
                              SizedBox(width: 4.w),
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
              width: 120.w,
              height: 100,
              child: Material(
                color: Colors.transparent,
                child: actionWidget(
                  ticket.idStatus,
                  ticket.statusImage(),
                  function,
                  ticket,
                  context,
                ),
              ),
            )
        ],
      ),
    );
  }
}

Widget actionWidget(int idStatus, String statusImage, VoidCallback? action,
    Ticket ticket, BuildContext context) {
  if (idStatus == 1) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogForm(
            title: 'Cancelar Ticket?',
            action: () => action!(),
            colorConfirmButton: AppColors.red,
            message:
                "Caso você não irá utilizar este ticket, clique em sim para cancelar sua solicitação.",
          ),
        );
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
                child: Text(
              'Cancelar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.red,
                letterSpacing: -1,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            )),
          ),
        ],
      ),
    );
  } else if (idStatus == 2) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogForm(
            title: 'Confirmar Presença?',
            action: () => action!(),
            labelConfirmButton: "Confirmar",
            message:
                "Caso você irá utilizar este ticket, clique em confirmar para validar sua presença.",
          ),
        );
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
              child: Text(
                'Confirmar\nPresença',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    fontSize: 16.sp,
                    height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (idStatus == 4) {
    return InkWell(
      onTap: () {
        showQrCodeDialog(context, ticket.qrCodeInfo());
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
                color: AppColors.blue,
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
  return SizedBox(
    height: 50.h,
    width: 50.w,
  );
}
// 'Café da manhã',
// 'Utilização autorizada'