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
      meals = tables.meals.map((e) {
        if (e.description == 'Almoço') {
          e.description = '${e.description} (11:00 às 13:30)';
          return e;
        } else if (e.description == 'Jantar') {
          e.description = '${e.description} (18:00 às 19:30)';
          return e;
        } else {
          return e;
        }
      }).toList();
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

  /// Responsável por solicitar a refeição do tipo diária do aluno
  Future<void> createTickets(
    int id,
    int weekId,
    String useDay,
    String useDayDate,
    bool isCaeRequest,
  ) async {
    try {
      final ticketId = await TicketsApiRepositoryImpl().requestTicket(RequestTicketModel(
        studentId: id,
        mealId: meal!.id,
        justificationId: justification!.id,
        description: justificationController.text,
      ));

      if (isCaeRequest) {
        await TicketsApiRepositoryImpl().changeConfirmTicket(ticketId, 4);
      }
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
      RequestPermanent permanents = RequestPermanent(
        studentId: id,
        weekId: days.map((e) => e.id).toList(),
        mealId: meal!.id,
        justificationId: justification!.id,
        description: justificationController.text,
      );
      final permanentsIds = await TicketsApiRepositoryImpl().requestPermanent(permanents);

      if (isCae) {
        await TicketsApiRepositoryImpl().changeStatusAuthorizationPermanents(permanentsIds, 4);
      }
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

  bool checkJustificationAndMeal() {
    return justification != null && meal != null;
  }

  /// Verifica se a solicitação de refeição vem por parte da CAE ou do aluno
  Future<void> onTapSendRequest(bool isCae, bool lunch, bool dinner, {int? idStudent}) async {
    try {
      error = false;
      notifyListeners();

      if (!checkJustificationAndMeal()) {
        AppMessage.i.showInfo(
          'É obrigatório selecionar a Refeição e a Justificativa para solicitar o ticket!',
        );
        return;
      }

      if (lunch == false && meal!.id == 2 && !isPermanent) {
        AppMessage.i.showInfo(
          'Já existe um ticket para almoço, impossível nova solicitação!',
        );
        return;
      }

      if (dinner == false && meal!.id == 3 && !isPermanent) {
        AppMessage.i.showInfo(
          'Já existe um ticket para jantar, impossível nova solicitação!',
        );
        return;
      }
      
      final sp = await SharedPreferences.getInstance();
      final id = sp.getInt('idStudent');

      if (permanentDays.isNotEmpty && isPermanent) {
        await createPermanents(
          id ?? idStudent ?? 0,
          isCae,
          permanentDays,
        );
      } else if (isPermanent && permanentDays.isEmpty) {
        AppMessage.i.showInfo(
          'A escolha de um dia é obrigatória para a solicitação de permanentes!',
        );
        return;
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
