import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class DialogForm extends StatelessWidget {
  final VoidCallback? action;
  final String message;

  const DialogForm({
    Key? key,
    required this.action,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: const Text(
        'Cancelar Ticket',
        style: AppTextStyle.largeText,
      ),
      content: Text(
        message,
        style: AppTextStyle.normalText,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Não',
            style: AppTextStyle.normalText
                .copyWith(color: AppColors.red, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {
            action!();
            Navigator.pop(context, true);
          },
          child: Text(
            'Sim',
            style: AppTextStyle.normalText.copyWith(
                color: AppColors.green500, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
