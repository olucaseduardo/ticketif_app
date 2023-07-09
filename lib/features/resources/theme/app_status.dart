import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class AppStatus {
//TODO: Ajustar icones e cores
  List statusImage(String status) {
    if (status == 'Em análise') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Confirmar presença') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Aguardando pagamento') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Utilização autorizada') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Utilizado') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Cancelado') {
      return [Icons.access_time, AppColors.yellow];
    } else if (status == 'Não autorizado') {
      return [Icons.access_time, AppColors.yellow];
    }
    return [Icons.access_time, AppColors.yellow];
  }
}
