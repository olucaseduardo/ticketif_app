import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/navigation/special_navigation.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/dto/request_permanent.dart';
import 'package:ticket_ifma/features/repositories/request_tables/request_tables_api_impl.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:ticket_ifma/features/dto/days_ticket_dto.dart';
import 'package:ticket_ifma/features/dto/request_ticket_model.dart';
import 'package:ticket_ifma/features/models/tables_model.dart';
import 'package:ticket_ifma/features/resources/theme/app_theme.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestTicketController extends ChangeNotifier {
  bool isPermanent = false;
  bool error = false;
  TablesModel? meal;
  TablesModel? justification;
  TextEditingController justificationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<TablesModel> meals = [];
  List<TablesModel> justifications = [];
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

  /// Buscando as informações das tabelas de meals e justifications no banco
  Future<void> requestList() async {
    try {
      final tables = await RequestTablesApiImpl().listTables();
      meals = tables.meals;
      justifications = tables.justifications;
      meals.removeLast();
      meals.removeAt(0);
      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao carregar dados', error: e, stackTrace: s);
      AppMessage.i.showError('Erro ao carregar dados');
      throw RepositoryException(message: 'Erro ao carregar dados');
    }
  }

  /// Responsável pela exibição dos dias caso seja refeição permanente
  onPermanentChanged(bool? value) {
    isPermanent = value as bool;
    permanentDays = [];
    notifyListeners();
  }

  /// Responsável por listar os tipos de refeições para seleção
  onMealsChanged(String? value) {
    meal = meals.singleWhere((element) => element.description == value);

    notifyListeners();
  }

  /// Responsável por listar as justificativas para seleção
  onJustificationChanged(String? value) {
    justification =
        justifications.singleWhere((element) => element.description == value);

    notifyListeners();
  }

  /// Realiza as validações para que não haja erros nas requisições
  bool validation(bool isCae) {
    if (isPermanent && permanentDays.isEmpty) {
      AppMessage.i.showError('Selecione pelo menos um dia na semana');
      return false;
    }

    if (!formKey.currentState!.validate()) {
      return false;
    }

    final hour = DateTime.now().hour;
    final minutes = DateTime.now().minute;

    /// Verifica se o pedido de almoço ocorre dentro do horário estipulado
    if (((hour >= 8) && (hour <= 10 && minutes <= 30)) && isCae == false) {
      if (meal!.id == 2) {
        AppMessage.i.showInfo(
            'A solicitação está fora do período de ${meal!.description.toLowerCase()}');
        return false;
      }
    }

    return true;
  }

  /// Responsável por solicitar a refeição do tipo diária do aluno
  Future<void> createTickets(
    int id,
    int weekId,
    String useDay,
    String useDayDate,
    bool isCae,
  ) async {
    try {
      await TicketsApiRepositoryImpl().requestTicket(RequestTicketModel(
        studentId: id,
        weekId: weekId,
        mealId: meal!.id,
        statusId: isCae ? 4 : 1,
        justificationId: justification!.id,
        isPermanent: 0,
        solicitationDay: DateTime.now().toString(),
        useDay: useDay,
        useDayDate: useDayDate,
        paymentDay: '',
        text: justificationController.text,
      ));
    } on DioError catch (e, s) {
      log('Erro ao solicitar Ticket', error: e, stackTrace: s);

      error = true;
      notifyListeners();
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao solicitar Ticket', error: e, stackTrace: s);
    }
  }

  /// Responsável por solicitar a autorização para refeição permanente nos dias selecionados
  Future<void> createPermanents(
    int id,
    bool isCae,
    List<DaysTicketDto> days,
  ) async {
    try {
      List<RequestPermanent> permanents = [];

      for (var day in days) {
        permanents.add(RequestPermanent(
          studentId: id,
          weekId: day.id,
          mealId: meal?.id ?? 0,
          justificationId: justification?.id ?? 0,
          text: justificationController.text,
          useDay: day.description,
          useDayDate:
              day.id == DateTime.now().weekday ? DateTime.now().toString() : "",
          authorized: isCae ? 1 : 0,
          statusId: isCae ? 2 : 1,
        ));
      }

      await TicketsApiRepositoryImpl().requestPermanent(permanents);
    } on DioError catch (e, s) {
      log('Erro ao solicitar autorização permanente', error: e, stackTrace: s);

      error = true;
      notifyListeners();
    } catch (e, s) {
      error = true;
      notifyListeners();
      log('Erro ao solicitar Ticket', error: e, stackTrace: s);
    }
  }

  /// Verifica se a solicitação de refeição vem por parte da CAE ou do aluno
  Future<void> onTapSendRequest(bool isCae, {int? idStudent}) async {
    if (validation(isCae)) {
      try {
        error = false;
        notifyListeners();

        final sp = await SharedPreferences.getInstance();
        final id = sp.getInt('idStudent');

        if (permanentDays.isNotEmpty && isPermanent) {
          await createPermanents(
            id ?? idStudent ?? 0,
            isCae,
            permanentDays,
          );
        } else {
          await createTickets(
              id ?? idStudent ?? 0,
              DateTime.now().weekday,
              DateUtil.todayDateRequest(DateTime.now()).capitalizeRequest(),
              DateTime.now().toString(),
              isCae);
        }

        if (!error) {
          AppMessage.i.showMessage('Requisição enviada com sucesso');
          !isCae ? SpecialNavigation.i.isNotCae() : SpecialNavigation.i.isCae();
        } else {
          AppMessage.i.showError('Erro ao solicitar Ticket');
        }
      } on DioError catch (e, s) {
        log('Erro ao solicitar Ticket', error: e, stackTrace: s);
        AppMessage.i.showError('Erro ao solicitar Ticket');
        throw RepositoryException(message: 'Erro ao solicitar Ticket');
      }
    }
  }

  /// Exibe os dias abreviados para marcação
  bool selectedDays(String? value) {
    for (var element in permanentDays) {
      if (element.abbreviation == value) {
        return true;
      }
    }
    return false;
  }

  List<DaysTicketDto> listOfDays() {
    List<DaysTicketDto> order = [];
    for (var day in days) {
      for (var permanentDay in permanentDays) {
        if (day.id == permanentDay.id) order.add(day);
      }
    }
    return order;
  }

  onDaysChanged(String? value, bool? isSelected) {
    if (isSelected!) {
      if (!selectedDays(value)) {
        permanentDays
            .add(days.singleWhere((element) => element.abbreviation == value));
      }
      permanentDays = listOfDays();
      notifyListeners();
    } else {
      if (selectedDays(value)) {
        permanentDays.remove(
            days.singleWhere((element) => element.abbreviation == value));
      }
      permanentDays = listOfDays();
      notifyListeners();
    }
  }
}
