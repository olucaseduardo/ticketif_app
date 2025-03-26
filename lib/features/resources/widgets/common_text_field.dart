import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String? toolTip;
  final List<TextInputFormatter>? inputFormatters;

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
      this.toolTip,
      this.inputFormatters
  }) : obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColors.gray[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (toolTip != null && toolTip!.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    final tooltip = tooltipKey.currentState;
                    tooltip?.ensureTooltipVisible();
                  },
                  child: Tooltip(
                      preferBelow: false,
                      message: toolTip!,
                      key: tooltipKey,
                      waitDuration: Duration.zero,
                      showDuration: const Duration(seconds: 1),
                      child: const Icon(
                        Icons.info_outline,
                        color: AppColors.green,
                      )),
                )
            ],
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder<bool>(
            valueListenable: obscureTextVN,
            builder: (_, obscureTextValue, child) => TextFormField(
              inputFormatters: inputFormatters,
              controller: controller,
              obscureText: obscureTextValue,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLines: maxLine,
              style: AppTextStyle.labelLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                focusColor: AppColors.green,
                fillColor: AppColors.green,
                hoverColor: AppColors.green,
                labelText: labelText,
                labelStyle: AppTextStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                border: const OutlineInputBorder(),
                suffixIcon: obscureText
                    ? IconButton(
                        onPressed: () =>
                            obscureTextVN.value = !obscureTextValue,
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
