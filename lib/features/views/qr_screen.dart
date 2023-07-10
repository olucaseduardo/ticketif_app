import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/resources/widgets/qr_code_result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      ref.read(restaurantProvider).qrCodeController!.pauseCamera();
    } else if (Platform.isIOS) {
      ref.read(restaurantProvider).qrCodeController!.resumeCamera();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(restaurantProvider).qrCodeController?.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(restaurantProvider);

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
                visible: controller.qrResult != null,
                replacement: const Center(
                  child: Text('Sem dados no momento, escaneie um QR Code!'),
                ),
                child: QrCodeResult(qrResult: controller.qrResult)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
