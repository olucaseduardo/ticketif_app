import 'package:flutter/material.dart';
import 'package:TicketIFMA/features/resources/routes/app_routes.dart';
import 'package:TicketIFMA/features/resources/theme/app_text_styles.dart';
import 'package:TicketIFMA/features/resources/widgets/app_message.dart';
import 'package:TicketIFMA/features/resources/widgets/common_button_widget.dart';

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
            child: SizedBox(
              width: 200,
              child: CommonButton(
                textPadding: 8,
                function: () {
                  function?.call();
                  homeStudent == true
                      ? AppMessage.i.showError('Erro ao carregar usuario')
                      : null;

                  homeStudent == true
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, AppRouter.loginRoute, (route) => false)
                      : Navigator.pop(context);
                },
                label: msg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
