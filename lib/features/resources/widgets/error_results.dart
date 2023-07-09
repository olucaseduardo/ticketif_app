import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                function?.call();
                homeStudent == true ? AppMessage.showError('Erro ao carregar usuario') : null;
                     
                homeStudent == true ? Navigator.pushNamedAndRemoveUntil(context,
                          AppRouter.loginRoute, (route) => false) :
                Navigator.pop(context);
              },
              child: Text(
                msg,
                style:
                    AppTextStyle.largeText.copyWith(color: AppColors.green500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
