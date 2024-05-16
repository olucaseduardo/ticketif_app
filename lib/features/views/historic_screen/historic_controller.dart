import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/repositories/tickets/tickets_api_repository_impl.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';

class HistoricController extends ChangeNotifier {
  DateTime? day;
  DateTime changeDate = DateUtil.dateTimeNow;
  List<Ticket> tickets = [];
  List<Ticket> historicTickets = [];
  String statusValue = 'Todos';
  Map<int, String> status = {0: 'Todos'};
  bool isLoading = false;
  bool error = false;


  void loadData(List<Ticket> data) {
    tickets = data;
    historicTickets = data;
    for(int index = 0; index < data.length; index++){
      int key = data.elementAt(index).idStatus;
      if(!status.containsKey(key)){
        status[key] = data.elementAt(index).status;
      }
    }

    log('Status ${status.toString()}');
  }

  // void initDate() {
  //   changeDate = day == null ? DateUtil.dateTimeNow : day as DateTime;
  // }

  List<Ticket> getHistoricTickets(DateTime? date) {
    if (date != null) {
      return tickets
          .where((e) =>
              DateTime.parse(e.useDayDate).day == date.day &&
              DateTime.parse(e.useDayDate).month == date.month &&
              DateTime.parse(e.useDayDate).year == date.year)
          .toList();

    } else {
      return tickets;
    }
  }

  void onStatusChanged(String? value){
        statusValue = value as String;
        if(value == 'Todos'){
          historicTickets = tickets;
        }else{
          historicTickets = tickets.where((element) => element.status == value).toList();
        }
        day = null;
        notifyListeners();
  }

  void updateDate(DateTime? pickDate) {
    if (pickDate != null) {
      day = pickDate;
      changeDate = pickDate;
      statusValue = 'Todos';
      historicTickets = getHistoricTickets(day);
      notifyListeners();
    }
  }

  Future<void> cancelTicket(int idTicket) async {
    try {
      isLoading = true;
      error = false;

      await TicketsApiRepositoryImpl().changeStatusTicket(idTicket, 6);
      var ticketSelected = tickets.where((t) => t.id == idTicket).first;
      int indiceTicket = tickets.indexWhere((t) => t.id == idTicket);

      ticketSelected.status = 'Cancelado';
      ticketSelected.idStatus = 6;

      tickets.replaceRange(indiceTicket, indiceTicket + 1, [ticketSelected]);

      isLoading = false;
      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao cancelar ticket', error: e, stackTrace: s);
      isLoading = false;
      error = true;
      throw RepositoryException(message: 'Erro ao cancelar ticket');
    }
  }

  Future<void> confirmTicket(int idTicket) async {
    final hour = DateTime.now().hour;

    if (!(hour > 12 || (hour >= 7 && hour < 9))) {
      AppMessage.i
          .showInfo('A confirmação só está disponível no período das 7h às 9h');
      return;
    }

    try {
      isLoading = true;
      error = false;

      await TicketsApiRepositoryImpl().changeStatusTicket(idTicket, 4);
      var ticketSelected = tickets.where((t) => t.id == idTicket).first;
      int indiceTicket = tickets.indexWhere((t) => t.id == idTicket);

      ticketSelected.status = 'Utilização autorizada';
      ticketSelected.idStatus = 4;

      tickets.replaceRange(indiceTicket, indiceTicket + 1, [ticketSelected]);

      isLoading = false;
      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao cancelar ticket', error: e, stackTrace: s);
      isLoading = false;
      error = true;
      throw RepositoryException(message: 'Erro ao cancelar ticket');
    }
  }
}
