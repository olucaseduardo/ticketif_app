import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:validatorless/validatorless.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final int? maxLine;
  final TextEditingController? controller;
  final bool? validator;

  CommonTextField({
    super.key,
    this.controller,
    required this.title,
    required this.labelText,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.maxLine = 1,
    this.validator = false,
  }) : obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: AppTextStyle.titleSmall,
          ),
          const SizedBox(height: 4),

          ValueListenableBuilder<bool>(
            valueListenable: obscureTextVN,

            builder: (_, obscureTextValue, child) => TextFormField(
              controller: controller,
              obscureText: obscureTextValue,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLines: maxLine,

              decoration: InputDecoration(
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,

                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green),
                ),

                focusColor: AppColors.green,
                fillColor: AppColors.green,
                hoverColor: AppColors.green,
                labelText: labelText,
                labelStyle: const TextStyle(color: AppColors.gray),
                border: const OutlineInputBorder(),

                suffixIcon: obscureText
                  ? IconButton(
                      onPressed: () => obscureTextVN.value = !obscureTextValue,
                      icon: obscureTextValue
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    )
                  : null,
              ),

              validator:
                  validator! ? Validatorless.required('Obrigatório!') : null,
            ),
          ),
        ],
      ),
    );
  }
}
