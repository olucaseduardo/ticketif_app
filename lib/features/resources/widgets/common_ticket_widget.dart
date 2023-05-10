import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_dialog.dart'
    as qr_code;

class CommonTicketWidget extends StatelessWidget {
  final String meal;
  final String status;

  const CommonTicketWidget({
    Key? key,
    required this.meal,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray900, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateUtil.ticketDay(dateTime),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray200)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Refeição',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.gray700),
                          ),
                          Text(meal,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.gray200))
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Status',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.gray700)),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_sharp,
                                size: 14,
                                color: AppColors.green500,
                              ),
                              const SizedBox(width: 4),
                              Text(status,
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.gray200))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const DottedLine(
                direction: Axis.vertical,
                lineLength: 60,
                dashLength: 2,
                dashColor: AppColors.blue,
              ),
              Material(
                color: AppColors.gray900,
                child: InkWell(
                  onTap: () => qr_code.showQrCodeDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      child: SvgPicture.asset('assets/svg/QrPay.svg',
                          height: 50, width: 50, color: AppColors.blue),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// 'Café da manhã',
// 'Utilização autorizada'