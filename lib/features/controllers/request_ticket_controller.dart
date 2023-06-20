// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/request_tables/request_tables_api_impl.dart';
import 'package:project_ifma_ticket/features/data/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/dto/days_ticket_dto.dart';
import 'package:project_ifma_ticket/features/dto/request_ticket_model.dart';
import 'package:project_ifma_ticket/features/models/tables_model.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestTicketController extends ChangeNotifier {
  bool isPermanent = false;
  TablesModel? meal;
  TablesModel? justification;
  TextEditingController justificationController = TextEditingController();

  List<TablesModel> meals = [];
  List<TablesModel> justifications = [];
  // List<String> days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
  List<DaysTicketDto> days = [
    DaysTicketDto(id: 1, description: "Segunda-Feira", abbreviation: "Seg"),
    DaysTicketDto(id: 2, description: "Terça-Feira", abbreviation: "Ter"),
    DaysTicketDto(id: 3, description: "Quarta-Feira", abbreviation: "Qua"),
    DaysTicketDto(id: 4, description: "Quinta-Feira", abbreviation: "Qui"),
    DaysTicketDto(id: 5, description: "Sexta-Feira", abbreviation: "Sex"),
    DaysTicketDto(id: 6, description: "Sábado", abbreviation: "Sab"),
    DaysTicketDto(id: 7, description: "Domingo", abbreviation: "Dom"),
  ];
  List<DaysTicketDto> permanentDays = [];

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
      print(DateTime.now().weekday);
    }
    notifyListeners();
  }

  onJustificationChanged(String? value) {
    justification =
        justifications.singleWhere((element) => element.description == value);
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

  void createTickets(int id) async {
    await TicketsApiRepositoryImpl().requestTicket(RequestTicketModel(
      studentId: id,
      weekId: 2,
      mealId: meal!.id,
      statusId: 1,
      justificationId: justification!.id,
      isPermanent: isPermanent ? 1 : 0,
      solicitationDay: DateTime.now().toString(),
      useDay: 'Terça-Feira',
      useDayDate: DateTime.now().toString(),
      paymentDay: '',
      text: justificationController.text,
    ));
  }

  Future<void> onTapSendRequest() async {
    if (validation()) {
      try {
        final sp = await SharedPreferences.getInstance();
        final id = sp.getInt('idStudent');

        createTickets(id ?? 0);
        AppMessage.showMessage('Requisição enviada com sucesso');
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          AppRouter.homeRoute,
          (route) => false,
        );
      } on DioError catch (e, s) {
        log("Erro ao solicitar ticket", error: e, stackTrace: s);
        throw RepositoryException(message: 'Erro ao solicitar ticket');
      }
    }
  }

  bool selectedDays(String? value) {
    for (var element in permanentDays) {
      if (element.abbreviation == value) {
        return true;
      }
    }
    return false;
  }

  //TODO: most efficient method for the future
  List<DaysTicketDto> listOfDays() {
    List<DaysTicketDto> order = [];
    for (var day in days) {
      for (var permanentDay in permanentDays) {
        if (day.id == permanentDay.id) order.add(day);
      }
    }
    order.forEach((element) {
      print(element.abbreviation);
    });
    return order;
  }

  onDaysChanged(String? value, bool? isSelected) {
    if (isSelected!) {
      if (!selectedDays(value)) {
        permanentDays
            .add(days.singleWhere((element) => element.abbreviation == value));
      }
      permanentDays = listOfDays();
      if (kDebugMode) {
        permanentDays.forEach((element) {
          print(element.description);
        });
      }
      notifyListeners();
    } else {
      if (selectedDays(value)) {
        permanentDays.remove(
            days.singleWhere((element) => element.abbreviation == value));
      }
      permanentDays = listOfDays();
      if (kDebugMode) {
        permanentDays.forEach((element) {
          print(element.description);
        });
        ;
      }
      notifyListeners();
    }
  }
}
