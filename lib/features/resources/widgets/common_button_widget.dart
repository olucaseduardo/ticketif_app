import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? function;
  final String label;
  final double? textPadding;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  const CommonButton({
    Key? key,
    required this.label,
    this.textPadding,
    this.textStyle,
    this.style,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: function,
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(textPadding ?? 14.sp),
            child: Text(label, style: textStyle ?? AppTextStyle.titleMedium),
          ),
        ),
      );
}
