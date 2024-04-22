import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<String?> showQrCodeDialog(BuildContext context, String data) =>
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
              Center(
                child: Text(
                  'Aponte o QR Code para a câmera do(a) vendedor(a) para validar o pagamento.',
                  style: AppTextStyle.smallText,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(child: showQrCode(data)),
            ],
          ),
        ),
      ),
    );

QrImageView showQrCode(String data) =>
    QrImageView(data: data, version: QrVersions.auto, size: 250);
