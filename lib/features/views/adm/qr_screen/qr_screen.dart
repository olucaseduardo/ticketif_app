import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {
  @override
  void initState() {
    ref.read(qrProvider).initPackages();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      ref.read(qrProvider).qrCodeController!.pauseCamera();
    } else if (Platform.isIOS) {
      ref.read(qrProvider).qrCodeController!.resumeCamera();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(qrProvider).qrCodeController?.dispose();
  }

  @override
  void dispose() {
    reassemble();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(qrProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR CODE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Visibility(
                  visible: controller.isValid,
                  replacement: Center(
                    child: Text(
                      controller.result,
                      style: AppTextStyle.titleMedium.copyWith(
                        color: AppColors.green300,
                      ),
                    ),
                  ),
                  child: QrCodeResult(qrResult: controller.qrResult)),
            ),
            Text(
              'Total Validados: ${controller.totalValid.toString()}',
              style: AppTextStyle.titleLarge.copyWith(
                color: AppColors.green300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
