import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

class ErrorResults extends StatelessWidget {
  final String msg;
  final String msgError;
  final VoidCallback? function;
  final VoidCallback? login;
  final VoidCallback? reload;

  const ErrorResults(
      {super.key,
      required this.msg,
      this.function,
      required this.msgError,
      this.login,
      this.reload});

  @override
  Widget build(BuildContext context) {
    if (function != null) {
      function!();
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/alert.png'),
          Text(
            msgError,
            style: AppTextStyle.normalText,
          ),
          const SizedBox(
            height: 20,
          ),
          login != null
              ? ElevatedButton(
                  onPressed: login, child: const Text("Voltar para o Login"))
              : const SizedBox(),
          reload != null
              ? ElevatedButton(
                  onPressed: reload!, child: const Text("Carregar novamente"))
              : const SizedBox()
        ],
      ),
    );
  }
}
