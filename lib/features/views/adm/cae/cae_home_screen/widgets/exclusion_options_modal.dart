import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/cae_controller.dart';

class ExclusionOptionsModal extends StatelessWidget {
  final CaeController controller;
  const ExclusionOptionsModal({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selecione uma das opções abaixo',
                  style: AppTextStyle.titleMedium,
                ),
                const SizedBox(height: 16),
                CommonButton(
                  label: 'Deletar todos os permanentes',
                  function: () {
                    controller.deleteAllPermanents();
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
                CommonButton(
                  label: 'Deletar todos os tickets diários',
                  function: () {
                    controller.deleteAllTickets();
                    Navigator.of(context).pop();
                  }
                ),
                const SizedBox(height: 10),
                CommonButton(
                  label: 'Deletar todos os alunos',
                  function: () {
                    controller.deleteAllStudents();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
