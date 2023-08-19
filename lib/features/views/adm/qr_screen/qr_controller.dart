import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/dto/qr_result.dart';
import 'package:project_ifma_ticket/features/repositories/tickets/tickets_api_repository_impl.dart';
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
    controller.scannedDataStream.listen((scanData) async {
      if (ready) {
        log(ready.toString());
        ready = false;
        return;
      }

      if (scanData.code != null) {
        ready = false;

        await Future.delayed(Duration(seconds: timeBetweenReadsInSeconds), () {
          ready = true;
          isValid = false;
          result = 'Sem dados no momento, escaneie um QR Code';
          notifyListeners();
          log(':::::: DELAY:::::::');
        });

        qrResult = QrResult.fromJson(scanData.code!);

        bool checkDate =
            DateUtil.checkTodayDate(DateTime.parse(qrResult!.date));

        if (qrResult!.status == "Utilização autorizada" && checkDate) {
          if (validatedTickets.contains(qrResult!.id.toString()) ||
              uploadedTickets.contains(qrResult!.id.toString())) {
            result = 'Ticket ${qrResult!.id} já validado';
            Vibration.vibrate(duration: 300);
            notifyListeners();
          } else {
            Vibration.vibrate(duration: 300);
            validatedTickets.add(qrResult!.id.toString());

            prefs.setStringList('validatedTickets', validatedTickets);
            isValid = true;

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
                log('Erro ao atualizar lista de validados',
                    error: e, stackTrace: s);

                throw RepositoryException(
                    message: 'Erro ao alterar status do ticket');
              }
            }

            result = 'Ticket validado: ${qrResult!.student}';
            totalValid = validatedTickets.length + uploadedTickets.length;
            notifyListeners();
          }
        } else {
          result = 'Ticket inválido';
        }
      }
    });
  }
}
