import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

class CommonDropDownButton extends StatelessWidget {
  final String? hint;
  final String? value;
  final List<String> items;
  final bool isDense;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropDownButton(
      {super.key,
      this.hint,
      this.value,
      required this.items,
      this.isDense = false,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
        ),
        contentPadding: isDense
            ? const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              )
            : const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
        focusColor: AppColors.green,
        fillColor: AppColors.green,
        hoverColor: AppColors.green,
        labelStyle: AppTextStyle.labelLarge.copyWith(
          fontWeight: FontWeight.w500,
        ),
        border: const OutlineInputBorder(),
      ),
      borderRadius: BorderRadius.circular(4.0),
      value: value,
      isExpanded: true,
      hint: Text(
        hint ?? "",
        maxLines: 1,
        style: AppTextStyle.labelLarge.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      items: items
          .map(
            (element) => DropdownMenuItem(
              value: element,
              child: Text(
                element,
                style: AppTextStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
