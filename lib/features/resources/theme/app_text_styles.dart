import 'package:flutter/material.dart';
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
      
  static const smallBody = TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
  );

  static const bodyMedium = TextStyle(
    fontSize: 12,
    letterSpacing: 0.25,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const labelSmall = TextStyle(
    fontSize: 11,
    letterSpacing: 0.5,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    letterSpacing: 0.5,
  );

  static const labelLarge = TextStyle(
    fontSize: 14,
    letterSpacing: 0.1,
  );

  static const labelBig = TextStyle(
    fontSize: 18,
    letterSpacing: 0.1,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
    letterSpacing: 0.1,
  );

  static const titleMedium = TextStyle(
    fontSize: 16,
    letterSpacing: 0.15,
  );

  static const titleLarge = TextStyle(
    fontSize: 22,
  );
}
