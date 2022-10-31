import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Row(
          children: [
            Column(
              children: [
                
                Text(DateUtil.ticketDay(dateTime), style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.gray200)),
                Row(
                  children: [
                    Column(
                      children: [Text('Refeição'), Text('Café da manhã')],
                    ),
                    Column(
                      children: [
                        Text('Status'),
                        Row(
                          children: [
                            Icon(Icons.check_circle_sharp),
                            Text('Utilização autorizada')
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
