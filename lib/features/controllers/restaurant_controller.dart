import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/dto/qr_result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RestaurantController extends ChangeNotifier {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QrResult? qrResult;
  QRViewController? qrCodeController;

  void onQRViewCreated(QRViewController controller) {
    qrCodeController = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      qrResult = QrResult.fromJson(result?.code ?? '');
      log(result?.code.toString() ?? '');
      log(qrResult.toString());
      notifyListeners();
    });
  }
}
