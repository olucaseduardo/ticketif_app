import 'package:ticket_ifma/features/models/ticket.dart';

class TodayTicketsHelper {
  TodayTicketsHelper._();

  static TodayTicketsHelper? _instance;

  static TodayTicketsHelper get i {
    _instance ??= TodayTicketsHelper._();
    return _instance!;
  }

  Map<int, List<Ticket>> mapList(List<Ticket> todayTickets) {
    const statusPriority = [4, 2, 1, 5, 6, 7];

    Map<int, List<Ticket>>? todayTicketsMap = {};
    for (Ticket ticket in todayTickets) {
      if (!todayTicketsMap.containsKey(ticket.idMeal)) {
        todayTicketsMap[ticket.idMeal] = [];
      }
      todayTicketsMap[ticket.idMeal]!.add(ticket);
    }

    todayTicketsMap.forEach((key, tickets) {
      tickets.sort((a, b) {
        int aStatusPriority = statusPriority.indexOf(a.idStatus);
        int bStatusPriority = statusPriority.indexOf(b.idStatus);

        return aStatusPriority.compareTo(bStatusPriority);
      });
    });

    return todayTicketsMap;
  }
}
