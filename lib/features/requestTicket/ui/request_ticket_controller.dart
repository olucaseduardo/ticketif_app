import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';

class RequestTicketController extends ChangeNotifier {
  bool isPermanent = false;
  String? meal;
  String? justification;
  TextEditingController justificationController = TextEditingController();

  List<String> meals = <String>['Café da manhã', 'Almoço', 'Jantar', 'Ceia'];
  List<String> justifications = <String>[
    'Contra-turno',
    'Monitoria',
    'Estudos',
    'Evento',
    'Outro'
  ];
  List<String> days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
  List<String> permanentDays = [];

  onPermanentChanged(bool? value) {
    isPermanent = value as bool;
    permanentDays = [];
    notifyListeners();
  }

  onMealsChanged(String? value) {
    meal = value as String;
    print('Meal: $meal');
    notifyListeners();
  }

  onJustificationChanged(String? value) {
    justification = value as String;
    print('Justification: $justification');
    notifyListeners();
  }

  bool validation() {
    if (meal == null) {
      AppMessage.showError('Selecione uma refeição');
      return false;
    }
    if (isPermanent && permanentDays.isEmpty) {
      AppMessage.showError('Selecione pelo menos um dia na semana');
      return false;
    }
    if (justification == null) {
      AppMessage.showError('Selecione uma justificativa');
      return false;
    }
    return true;
  }

  onTapSendRequest() {
    if (validation()) {
      AppMessage.showMessage('Requisição enviada com sucesso');
    }
  }

  bool selectedDays(String? value) {
    if (permanentDays.contains(value)) {
      return true;
    }
    return false;
  }

  //TODO: most efficient method for the future
  List<String> listOfDays() {
    List<String> order = [];
    for (var day in days) {
      for (var permanentDay in permanentDays) {
        if (day == permanentDay) order.add(day);
      }
    }
    return order;
  }

  onDaysChanged(String? value, bool? isSelected) {
    if (isSelected!) {
      if (!permanentDays.contains(value)) permanentDays.add(value as String);
      permanentDays = listOfDays();
      print('Permanent Days: $permanentDays');
      notifyListeners();
    } else {
      if (permanentDays.contains(value)) permanentDays.remove(value);
      permanentDays = listOfDays();
      print('Permanent Days: $permanentDays');
      notifyListeners();
    }
  }
}
