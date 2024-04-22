import 'package:flutter/material.dart';
import 'package:TicketIFMA/features/resources/theme/app_colors.dart';

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
      decoration: InputDecoration(
        alignLabelWithHint: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
        ),
        focusColor: AppColors.green,
        fillColor: AppColors.green,
        hoverColor: AppColors.green,
        labelStyle: TextStyle(color: AppColors.gray[700]),
        border: const OutlineInputBorder(),
      ),
      borderRadius: BorderRadius.circular(4.0),
      isExpanded: true,
      hint: Text(
        hint!,
        style: TextStyle(color: AppColors.gray[700]),
      ),
      items: items
          .map((element) =>
              DropdownMenuItem(value: element, child: Text(element)))
          .toList(),
      onChanged: (value) => onChanged(value),
    );
  }
}
