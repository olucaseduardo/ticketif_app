
import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';

class PermanentsScreenController extends ChangeNotifier {
  List<PermanentModel> authorizations = [];

  void loadData(List<PermanentModel> data) {
    authorizations = data;
  }
}