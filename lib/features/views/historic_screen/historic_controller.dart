import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/features/models/ticket.dart';

class HistoricController extends ChangeNotifier {
  DateTime? day;
  DateTime changeDate = DateUtil.dateTimeNow;
  List<Ticket> tickets = [];
  List<Ticket> historicTickets = [];
  String statusValue = 'Todos';
  Map<int, String> status = {0: 'Todos'};


  void loadData(List<Ticket> data) {
    tickets = data;
    historicTickets = data;
    for(int index = 0; index < data.length; index++){
      int key = data.elementAt(index).idStatus;
      if(!status.containsKey(key)){
        status[key] = data.elementAt(index).status;
      }
    }

    print('Status ${status.toString()}');
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
}
