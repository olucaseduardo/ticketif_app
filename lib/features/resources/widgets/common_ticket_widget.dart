import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/dialog.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_dialog.dart'
    as qr_code;
import 'package:project_ifma_ticket/core/utils/path_image.dart' as path_image;

class CommonTicketWidget extends StatelessWidget {
  final String meal;
  final String status;
  final String statusImage;
  final String date;
  final VoidCallback? function;

  const CommonTicketWidget(
      {Key? key,
      required this.meal,
      required this.status,
      required this.statusImage,
      required this.date,
      this.function})
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Refeição:',
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.gray700),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(meal,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.gray200))
                        ],
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Row(
                        children: [
                          Text('Status:',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.gray700)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                statusImage,
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(width: 4.w),
                              Text(status,
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.gray200))
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
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Align(
                    child: actionWidget(status, statusImage, function, context),
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

Widget actionWidget(String status, String statusImage, VoidCallback? action,
    BuildContext context) {
  if (status == 'Em análise') {
    return InkWell(
      onTap: () {
        // AppMessage.showInfo('Teste de passagem');
        showDialog(
            context: context,
            builder: (_) => DialogForm(
                action: () => action!(),
                message:
                    "Clique sim para cancelar o ticket e não desfazer esta ação"));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Cancelar',
          style: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp),
        ),
      ),
    );
  } else if (status == 'Confirmar presença') {
    return InkWell(
      onTap: () {},
      child: Text('Confirmar\nPresença',
          style: TextStyle(
              color: AppColors.green500,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp)),
    );
  } else if (status == 'Utilização autorizada') {
    return SvgPicture.asset(path_image.qrUse,
        height: 50, width: 50, color: AppColors.blue);
  } else if (status == 'Utilizado') {
    return const Icon(
      Icons.check_circle_rounded,
      size: 50,
      color: AppColors.green500,
    );
  } else if (status == 'Cancelado') {
    return Icon(
      Icons.cancel_rounded,
      size: 50.r,
      color: AppColors.red,
    );
  } else if (status == 'Não autorizado') {
    return Icon(
      Icons.error,
      size: 50.r,
      color: AppColors.yellow,
    );
  }
  return SizedBox(
    height: 50.h,
    width: 50.w,
  );
}
// 'Café da manhã',
// 'Utilização autorizada'