import 'package:flutter/material.dart';
import 'package:TicketIFMA/core/utils/date_util.dart';
import 'package:TicketIFMA/features/dto/qr_result.dart';
import 'package:TicketIFMA/features/resources/theme/app_colors.dart';
import 'package:TicketIFMA/features/resources/theme/app_text_styles.dart';

class QrCodeResult extends StatelessWidget {
  final QrResult? qrResult;

  const QrCodeResult({super.key, required this.qrResult});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TICKET VALIDADO',
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.green[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Refeição: ${qrResult?.meal ?? ''}',
          style: AppTextStyle.titleMedium.copyWith(color: AppColors.green[300]),
        ),
        Text(
          qrResult?.date != null
              ? 'Data de Uso: ${DateUtil.todayDate(DateTime.parse(qrResult!.date))}'
              : '',
          style: AppTextStyle.titleMedium.copyWith(color: AppColors.green[300]),
        ),
        Text(
          'Nome do Aluno: ${qrResult?.studentName ?? ''}',
          style: AppTextStyle.titleMedium.copyWith(color: AppColors.green[300]),
        ),
        Text(
          'Matricula do Aluno: ${qrResult?.student ?? ''}',
          style: AppTextStyle.titleMedium.copyWith(color: AppColors.green[300]),
        ),
      ],
    );
  }
}
