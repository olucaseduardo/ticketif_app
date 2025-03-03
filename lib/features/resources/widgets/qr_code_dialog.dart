import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<String?> showQrCodeDialog(BuildContext context, Ticket ticket) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ),
              const Center(
                child: Text(
                  'Validação de pagamento',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Center(child: showQrCode(ticket.qrCodeInfo())),
              const Center(
                child: Text(
                  "Informações do Estudante",
                  textAlign: TextAlign.center,
                  style:AppTextStyle.titleMedium
                )
              ),
              Center(
                child: Text(
                  '${ticket.studentName}'
                      '\n${ticket.meal}',
                  style: AppTextStyle.normalText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );

QrImageView showQrCode(String data) =>
    QrImageView(data: data, version: QrVersions.auto, size: 250);
