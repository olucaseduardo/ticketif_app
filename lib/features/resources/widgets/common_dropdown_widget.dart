import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class CommonDropDownButton extends StatelessWidget {
  final String? hint;
  final List<String> items;
  final Function onChanged;

  const CommonDropDownButton(
      {Key? key, this.hint, required this.items, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green500)),
        focusColor: AppColors.green500,
        fillColor: AppColors.green500,
        hoverColor: AppColors.green500,
        labelStyle: TextStyle(color: AppColors.gray700),
        border: OutlineInputBorder(),
      ),
      borderRadius: BorderRadius.circular(4.0),
      isExpanded: true,
      hint: Text(hint!, style: const TextStyle(color: AppColors.gray700),),
      items: items
          .map((element) =>
              DropdownMenuItem(value: element, child: Text(element)))
          .toList(),
      onChanged: (value) => onChanged(value),
    );
  }
}
