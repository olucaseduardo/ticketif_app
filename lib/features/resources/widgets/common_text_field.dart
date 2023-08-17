import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:validatorless/validatorless.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLine;
  final TextEditingController? controller;
  final bool? validator;

  const CommonTextField({
    Key? key,
    this.controller,
    required this.title,
    required this.labelText,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.maxLine = 1,
    this.validator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              title,
              style: AppTextStyle.bodyLarge,
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLines: maxLine,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green500)),
              focusColor: AppColors.green500,
              fillColor: AppColors.green500,
              hoverColor: AppColors.green500,
              labelText: labelText,
              labelStyle: const TextStyle(color: AppColors.gray700),
              border: const OutlineInputBorder(),
            ),
            validator: validator! ? Validatorless.required('Obrigatório!') : null,
          ),
        ],
      ),
    );
  }
}
