import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  static const buttonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const smallButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static TextStyle smallText =
      TextStyle(fontSize: 14, color: AppColors.gray[600]);

  static TextStyle normalText =
      TextStyle(fontSize: 16, color: AppColors.gray[700]);

  static TextStyle largeText = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const smallBody = TextStyle(
    fontSize: 12,
    letterSpacing: -0.7,
  );

  static const bodyMedium = TextStyle(
    fontSize: 12,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
  );

  static const labelSmall = TextStyle(
    fontSize: 11,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
  );

  static const labelLarge = TextStyle(
    fontSize: 14,
  );

  static const labelBig = TextStyle(
    fontSize: 18,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
  );

  static const titleMedium = TextStyle(
    fontSize: 16,
  );

  static const titleLarge = TextStyle(
    fontSize: 22,
  );
}
