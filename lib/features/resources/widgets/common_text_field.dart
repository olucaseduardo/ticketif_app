import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keybordType;
  final bool obscureText;

  const CommonTextField(
      {Key? key,
      required this.title,
      required this.labelText,
      this.textInputAction,
      this.keybordType,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: AppColors.gray400),
            ),
          ),
          TextFormField(
            obscureText: obscureText,
            keyboardType: keybordType,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green500)),
              focusColor: AppColors.green500,
              fillColor: AppColors.green500,
              hoverColor: AppColors.green500,
              labelText: labelText,
              labelStyle: TextStyle(color: AppColors.gray700),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
