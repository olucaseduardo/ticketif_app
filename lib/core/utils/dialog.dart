import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';

class DialogForm extends StatelessWidget {
  final VoidCallback? action;
  final String message;
  final String title;
  final Color? colorConfirmButton;
  final TextStyle? confirmButtonTextStyle;
  final String labelConfirmButton;

  const DialogForm({
    Key? key,
    required this.action,
    required this.message,
    required this.title,
    this.labelConfirmButton = 'Sim',
    this.colorConfirmButton,
    this.confirmButtonTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        style: AppTextStyle.smallText,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        CommonButton(
          function: () {
            action!();
            Navigator.pop(context, true);
          },
          label: labelConfirmButton,
          textStyle: confirmButtonTextStyle ??
              AppTextStyle.titleMedium.copyWith(
                color: AppColors.black,
              ),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorConfirmButton ?? AppColors.green,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CommonButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.gray[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            function: () => Navigator.pop(context, false),
            label: 'Voltar',
            textStyle: AppTextStyle.titleMedium.copyWith(
              color: AppColors.black,
            )),
      ],
    );
  }
}
