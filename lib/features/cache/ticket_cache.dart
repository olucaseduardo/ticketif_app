import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/features/models/ticket.dart';

class TicketCache {
  static Future<void> saveTickets(List<Ticket> tickets) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String> ticketsSerialize =
        tickets.map((e) => e.toJson()).toList();
    await sp.setStringList("tickets", ticketsSerialize);
  }

  static Future<List<Ticket>> getTickets() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? ticketsSerialize = sp.getStringList("tickets");
    if (ticketsSerialize == null) {
      return [];
    }
    return List<Ticket>.from(ticketsSerialize.map((e) => Ticket.fromJson(e)));
  }
}
