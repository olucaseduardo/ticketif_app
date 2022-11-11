import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class CommomTicketWidget extends StatelessWidget {
  const CommomTicketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray900, borderRadius: BorderRadius.circular(4)),
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refeição',
                            style: TextStyle(
                                fontSize: 10.sp, color: AppColors.gray700),
                          ),
                          Text('Café da manhã',
                              style: TextStyle(
                                  fontSize: 10.sp, color: AppColors.gray200))
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
                                  fontSize: 10.sp, color: AppColors.gray700)),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_sharp,
                                size: 14.w,
                                color: AppColors.green500,
                              ),
                              SizedBox(width: 4.w),
                              Text('Utilização autorizada',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColors.gray200))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: const DottedLine(
                  direction: Axis.vertical,
                  lineLength: 60,
                  dashLength: 2,
                  dashColor: AppColors.blue,
                ),
              ),
              Column(
                children: [
                  SvgPicture.asset('svg/QrCode.svg',
                      height: 28.h, width: 28.w, color: AppColors.blue),
                  Text('Pagar',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
