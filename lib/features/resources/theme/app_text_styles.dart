import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  static final buttonTextStyle =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
  static final smallButton = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
  static final smallText = TextStyle(fontSize: 14.sp, color: AppColors.gray700);
  static final normalText =
      TextStyle(fontSize: 16.sp, color: AppColors.gray400);
  static final largeText = TextStyle(
      fontSize: 22.sp, fontWeight: FontWeight.w700, color: AppColors.gray200);
}
