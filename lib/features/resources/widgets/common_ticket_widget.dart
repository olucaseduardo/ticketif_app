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
      padding: EdgeInsets.symmetric(vertical: 14),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.gray900, borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateUtil.ticketDay(dateTime),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray200)),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refeição',
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.gray700),
                            ),
                            Text('Café da manhã',
                                style: TextStyle(
                                    fontSize: 10, color: AppColors.gray200))
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status',
                                style: TextStyle(
                                    fontSize: 10, color: AppColors.gray700)),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle_sharp,
                                  size: 14,
                                  color: AppColors.green500,
                                ),
                                SizedBox(width: 4),
                                Text('Utilização autorizada',
                                    style: TextStyle(
                                        fontSize: 10, color: AppColors.gray200))
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: const DottedLine(
                    direction: Axis.vertical,
                    lineLength: 60,
                    dashLength: 2,
                    dashColor: AppColors.blue,
                  ),
                ),
                Column(
                  children: [
                    SvgPicture.asset('assets/svg/QrCode.svg',
                        height: 28, width: 28, color: AppColors.blue),
                    Text('Pagar',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
