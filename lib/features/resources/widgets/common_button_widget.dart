import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final double? textPadding;
  final TextStyle? textStyle;
  const CommonButton(
      {Key? key,
      required this.label,
      this.textPadding,
      this.textStyle,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green500,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(textPadding ?? 18),
            child:
                Text(label, style: textStyle ?? AppTextStyle.buttonTextStyle),
          ),
        ),
      );
}
