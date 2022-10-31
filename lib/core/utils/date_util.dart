import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat todayWeekDayFormat =
      DateFormat("'Dia' d, EEEE", 'pt_BR');
  static String todayDate(DateTime dateTime) =>
      todayWeekDayFormat.format(dateTime);
  static final DateFormat dayMounthDayWeekFormat =
      DateFormat("'Dia' d 'de' MM (EEEE)", 'pt_BR');
  static String ticketDay(DateTime dateTime) =>
      dayMounthDayWeekFormat.format(dateTime);
}
