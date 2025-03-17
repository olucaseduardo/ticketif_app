import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

enum ButtonSize { small, medium, large }

class CommonButton extends StatelessWidget {
  final VoidCallback? function;
  final String label;
  final ButtonSize? size;
  final double? textPadding;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  const CommonButton({
    Key? key,
    required this.label,
    this.size = ButtonSize.medium,
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
            padding: textPadding != null
                ? EdgeInsets.all(textPadding!)
                : const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
            child: Text(label,
                style: textStyle ??
                    (size == ButtonSize.small
                        ? AppTextStyle.titleSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          )
                        : size == ButtonSize.medium
                            ? AppTextStyle.titleMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              )
                            : AppTextStyle.titleLarge.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ))),
          ),
        ),
      );
}
