import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/ticketif_alert.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/cae_controller.dart';

class ExclusionOptionsModal extends StatelessWidget {
  final CaeController controller;
  const ExclusionOptionsModal({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  showDialog(
                    context: context,
                    builder: (_) => TicketifAlert(
                      title: 'Deletar Permanentes',
                      content:
                          'Deseja realmente excluir todos os tickets permanentes da base de dados?',
                      function: controller.deleteAllPermanents,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              CommonButton(
                label: 'Deletar todos os tickets diários',
                function: () {
                  showDialog(
                    context: context,
                    builder: (_) => TicketifAlert(
                      title: 'Deletar Diários',
                      content:
                          'Deseja realmente excluir todos os tickets diários da base de dados?',
                      function: controller.deleteAllTickets,
                    ),
                  );
                }
              ),
              const SizedBox(height: 10),
              CommonButton(
                label: 'Deletar todos os alunos',
                function: () {
                  showDialog(
                    context: context,
                    builder: (_) => TicketifAlert(
                      title: 'Deletar Alunos',
                      content:
                          'Deseja realmente excluir todos os alunos da base de dados?',
                      function: controller.deleteAllStudents,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
