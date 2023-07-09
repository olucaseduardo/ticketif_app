import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class WithoutResults extends StatelessWidget {
  final String msg;
  const WithoutResults({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          msg,
          style: AppTextStyle.normalText,
        ),
      ),
    );
  }
}
