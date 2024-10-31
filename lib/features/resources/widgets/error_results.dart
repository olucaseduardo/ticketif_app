import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

class ErrorResults extends StatelessWidget {
  final String msg;
  final String msgError;
  final VoidCallback? function;
  final bool? homeStudent;

  const ErrorResults({
    super.key,
    required this.msg,
    this.function,
    required this.msgError,
    this.homeStudent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/alert.png'),
          Text(
            msgError,
            style: AppTextStyle.normalText,
          ),
        ],
      ),
    );
  }
}
