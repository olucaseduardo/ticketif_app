import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const buttonTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  static const smallButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static const smallText = TextStyle(fontSize: 14, color: AppColors.gray700);
  static const normalText = TextStyle(fontSize: 16, color: AppColors.gray400);
  static const largeText = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.gray200);
}
