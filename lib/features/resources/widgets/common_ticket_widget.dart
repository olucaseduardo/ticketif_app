import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_dialog.dart'
    as qr_code;

import 'package:project_ifma_ticket/core/utils/path_image.dart' as path_image;

class CommonTicketWidget extends StatelessWidget {
  final String meal;
  final String status;
  final String statusImage;
  final String date;

  const CommonTicketWidget(
      {Key? key,
      required this.meal,
      required this.status,
      required this.statusImage,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray900, borderRadius: BorderRadius.circular(4.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateUtil.ticketDay(DateTime.parse(date)),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray200)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refeição',
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.gray700),
                          ),
                          Text(meal,
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.gray200))
                        ],
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.gray700)),
                          Row(
                            children: [
                              SvgPicture.asset(
                                statusImage,
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(width: 4.w),
                              Text(status,
                                  style: const TextStyle(
                                      fontSize: 11, color: AppColors.gray200))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const DottedLine(
                direction: Axis.vertical,
                lineLength: 60,
                dashLength: 2,
                dashColor: AppColors.blue,
              ),
              Material(
                color: AppColors.gray900,
                child: InkWell(
                  onTap: () => qr_code.showQrCodeDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      child: actionWidget(status, statusImage),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget actionWidget(String status, String statusImage) {
  if (status == 'Em análise') {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Cancelar',
          style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w700),
        ));
  } else if (status == 'Confirmar presença') {
    return TextButton(
        onPressed: () {},
        child: const Text('Confirmar\nPresença',
            style: TextStyle(
                color: AppColors.green500, fontWeight: FontWeight.w700)));
  } else if (status == 'Utilização autorizada') {
    return SvgPicture.asset(statusImage,
        height: 50, width: 50, color: AppColors.blue);
  } else if (status == 'Utilizado') {
    return const Icon(
      Icons.check_circle_rounded,
      size: 50,
      color: AppColors.green500,
    );
  } else if (status == 'Cancelado') {
    return const Icon(
      Icons.cancel_rounded,
      size: 50,
      color: AppColors.red,
    );
  } else if (status == 'Não autorizado') {
    return const Icon(
      Icons.error,
      size: 50,
      color: AppColors.yellow,
    );
  }
  return const SizedBox(
    height: 50,
    width: 50,
  );
}
// 'Café da manhã',
// 'Utilização autorizada'