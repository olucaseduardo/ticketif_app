import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keybordType;
  final bool obscureText;
  final int? maxline;
  final TextEditingController? controller;

  const CommonTextField({
    Key? key,
    this.controller,
    required this.title,
    required this.labelText,
    this.textInputAction,
    this.keybordType,
    this.obscureText = false,
    this.maxline = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              title,
              style: AppTextStyle.normalText,
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keybordType,
            textInputAction: textInputAction,
            maxLines: maxline,
            decoration: InputDecoration(
              alignLabelWithHint: true,
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
