import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class TicketStatus {
  static (IconData, Color) statusImage(String status) {
    if (status == 'Em análise') {
      return (Icons.access_time, AppColors.yellow);
    } else if (status == 'Confirmar presença') {
      return (Icons.info, AppColors.yellow);
    } else if (status == 'Aguardando pagamento') {
      return (Icons.access_time, AppColors.yellow);
    } else if (status == 'Utilização autorizada') {
      return (Icons.check, AppColors.green);
    } else if (status == 'Utilizado') {
      return (Icons.food_bank, AppColors.green);
    } else if (status == 'Cancelado') {
      return (Icons.close, AppColors.yellow);
    } else if (status == 'Não autorizado') {
      return (Icons.error, AppColors.red);
    }
    return (Icons.access_time, AppColors.yellow);
  }
}
