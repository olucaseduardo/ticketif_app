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

  const CommonTicketWidget({
    Key? key,
    required this.meal,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
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
                  Text(DateUtil.ticketDay(dateTime),
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

                          const Text(

                            'Refeição',
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.gray700),
                          ),

                          Text(meal,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.gray200))

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
                                path_image.authorizedUse,
                                height: 12.h,
                                width: 12.w,
                              ),
                              // Icon(
                              //   Icons.check_circle_sharp,
                              //   size: 14.r,
                              //   color: AppColors.green500,
                              // ),
                              SizedBox(width: 4.w),
                              Text('Utilização autorizada',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.gray200))

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
                      child: SvgPicture.asset('assets/svg/QrPay.svg',
                          height: 50, width: 50, color: AppColors.blue),
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
// 'Café da manhã',
// 'Utilização autorizada'