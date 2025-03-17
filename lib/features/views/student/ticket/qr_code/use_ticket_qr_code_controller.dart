
import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/utils/links.dart';

class UseTicketQrCodeProvider extends ChangeNotifier {

  String getImageUrlStudent(String registration) {
    return "${Links.i.selectedLink}/student/$registration/photo";
  }
}