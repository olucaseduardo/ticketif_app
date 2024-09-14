import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

class TicketifAlert extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback function;

  const TicketifAlert({
    super.key,
    required this.title,
    required this.content,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTextStyle.titleMedium,
      ),
      content: Text(
        content,
        style: AppTextStyle.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancelar');
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            function();
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
