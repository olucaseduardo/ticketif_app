// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/data/request_tables/request_tables_api_impl.dart';
import 'package:project_ifma_ticket/features/data/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/dto/request_ticket_model.dart';
import 'package:project_ifma_ticket/features/models/list_tables_model.dart';
import 'package:project_ifma_ticket/features/models/tables_model.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestTicketController extends ChangeNotifier {
  bool isPermanent = false;
  TablesModel? meal;
  TablesModel? justification;
  TextEditingController justificationController = TextEditingController();

  List<TablesModel> meals = [];
  List<TablesModel> justifications = [];
  List<String> days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
  List<String> permanentDays = [];

  RequestTicketController() {
    requestList();
  }

  Future<void> requestList() async {
    try {
      final tables = await RequestTablesApiImpl().listTables();
      meals = tables.meals;
      justifications = tables.justifications;

      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar dados do usuário');
    }
  }

  onPermanentChanged(bool? value) {
    isPermanent = value as bool;
    permanentDays = [];
    notifyListeners();
  }

  onMealsChanged(String? value) {
    meal = meals.singleWhere((element) => element.description == value);
    if (kDebugMode) {
      print('Meal: $meal');
    }
    notifyListeners();
  }

  onJustificationChanged(String? value) {
    justification = justifications.singleWhere((element) => element.description == value);
    if (kDebugMode) {
      print('Justification: $justification');
    }
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

  Future<void> onTapSendRequest() async {
    if (validation()) {
      try {
        final sp = await SharedPreferences.getInstance();
        final id = sp.getInt('idStudent');

        await TicketsApiRepositoryImpl().requestTicket(RequestTicketModel(
          studentId: id ?? 0,
          weekId: 1,
          mealId: meal!.id,
          statusId: 1,
          justificationId: justification!.id,
          isPermanent: isPermanent ? 1 : 0,
          solicitationDay: DateTime.now().toString(),
          useDay: 'Terça-Feira',
          paymentDay: '',
          text: justificationController.text,
        ));
        AppMessage.showMessage('Requisição enviada com sucesso');
      } on DioError catch (e, s) {
        log("Erro ao solicitar ticket", error: e, stackTrace: s);
        throw RepositoryException(message: 'Erro ao solicitar ticket');
      }
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
      if (kDebugMode) {
        print('Permanent Days: $permanentDays');
      }
      notifyListeners();
    } else {
      if (permanentDays.contains(value)) permanentDays.remove(value);
      permanentDays = listOfDays();
      if (kDebugMode) {
        print('Permanent Days: $permanentDays');
      }
      notifyListeners();
    }
  }
}
