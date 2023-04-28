import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<String?> showQrCodeDialog(BuildContext context) => showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
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
              const Text('Validação de pagamento',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray200)),
              const Text(
                'Aponte o QR Code para a câmera do(a) vendedor(a) para validar o pagamento.',
                style: AppTextStyle.smallText,
              ),
              Center(child: showQrCode())
            ],
          ),
        ),
      ),
    );

Widget showQrCode() =>
    QrImage(data: 'Teste', version: QrVersions.auto, size: 200);
