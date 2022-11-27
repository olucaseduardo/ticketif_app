import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class HistoricScreen extends StatelessWidget {
  String title;
  HistoricScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Voltar',
          style: TextStyle(
              color: AppColors.gray200,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.gray200,
            )),
        titleTextStyle: const TextStyle(color: AppColors.gray200),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.gray200,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                title,
                style: AppTextStyle.largeText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
