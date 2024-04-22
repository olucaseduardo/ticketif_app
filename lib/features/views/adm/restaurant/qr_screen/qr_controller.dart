import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/dto/qr_result.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class QrController extends ChangeNotifier {
  QRViewController? qrCodeController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int totalValid = 0;
  final int timeBetweenReadsInSeconds = 3;
  bool ready = false;
  bool isValid = false;
  String result = 'Sem dados no momento, escaneie um QR Code';
  QrResult? qrResult;
  List<String> validatedTickets = [];
  List<String> uploadedTickets = [];
  late SharedPreferences prefs;

  void initPackages() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      validatedTickets = prefs.getStringList('validatedTickets') ?? [];
      uploadedTickets = prefs.getStringList('uploadedTickets') ?? [];

      totalValid = validatedTickets.length + uploadedTickets.length;
      notifyListeners();
    });
  }

  void onQRViewCreated(QRViewController controller) {
    qrCodeController = controller;
    controller.scannedDataStream.listen((scanData) {
      handleScanData(scanData);
    });
  }

  Future<void> handleScanData(Barcode scanData) async {
    if (ready) {
      await delayBetweenReads();
    }

    if (scanData.code != null) {
      ready = false;

      qrResult = QrResult.fromJson(scanData.code!);
      bool checkDate = DateUtil.checkTodayDate(DateTime.parse(qrResult!.date));

      if (qrResult!.status == "Utilização autorizada" && checkDate) {
        handleValidQRCode();
      } else {
        result = 'Ticket inválido';
      }

      await delayBetweenReads();
    }
  }

  Future<void> delayBetweenReads() async {
    await Future.delayed(Duration(seconds: timeBetweenReadsInSeconds));
    ready = true;
    isValid = false;
    result = 'Sem dados no momento, escaneie um QR Code';
    notifyListeners();
    log(':::::: DELAY:::::::');
  }

  void handleValidQRCode() async {
    if (isTicketAlreadyValidated(qrResult!.id.toString())) {
      result = 'Ticket ${qrResult!.id} já validado';
      Vibration.vibrate(duration: 300);
      notifyListeners();
    } else {
      markTicketAsValidated(qrResult!.id.toString());
      result = 'Ticket validado: ${qrResult!.student}';
      isValid = true;
      Vibration.vibrate(duration: 300);
      notifyListeners();
    }
  }

  bool isTicketAlreadyValidated(String ticketId) {
    return validatedTickets.contains(ticketId) ||
        uploadedTickets.contains(ticketId);
  }

  void markTicketAsValidated(String ticketId) async {
    validatedTickets.add(ticketId);
    prefs.setStringList('validatedTickets', validatedTickets);

    if (validatedTickets.length > 5) {
      result = "Atualizando lista de tickets validados...";
      notifyListeners();

      try {
        for (var element in validatedTickets) {
          await TicketsApiRepositoryImpl()
              .changeStatusTicket(int.parse(element), 5);
        }

        uploadedTickets.addAll(validatedTickets);
        prefs.setStringList('uploadedTickets', uploadedTickets);
        validatedTickets.clear();
        prefs.setStringList('validatedTickets', validatedTickets);
      } catch (e, s) {
        log('Erro ao atualizar lista de validados', error: e, stackTrace: s);
        throw RepositoryException(message: 'Erro ao alterar status do ticket');
      }
    }

    totalValid = validatedTickets.length + uploadedTickets.length;
  }
}
