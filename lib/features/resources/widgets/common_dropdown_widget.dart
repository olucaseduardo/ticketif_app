import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';

class CommonDropDownButton extends StatelessWidget {
  final String? hint;
  final List<String> items;
  final bool isDense;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropDownButton(
      {Key? key,
      this.hint,
      required this.items,
      this.isDense = false,
      required this.onChanged,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      validator: validator,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
        ),
        contentPadding: isDense
            ? const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              )
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        focusColor: AppColors.green,
        fillColor: AppColors.green,
        hoverColor: AppColors.green,
        labelStyle: TextStyle(color: AppColors.gray[700]),
        border: const OutlineInputBorder(),
      ),
      borderRadius: BorderRadius.circular(4.0),
      isExpanded: true,
      hint: Text(
        hint ?? "",
        maxLines: 1,
        style:
            TextStyle(color: AppColors.gray[700], fontSize: isDense ? 14 : 16),
      ),
      items: items
          .map((element) =>
              DropdownMenuItem(value: element, child: Text(element)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
