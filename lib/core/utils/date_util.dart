import 'package:intl/intl.dart';

class DateUtil {

  static final DateTime dateTime = DateTime.now();
  static final DateFormat todayWeekDayFormat =
      DateFormat("'Dia' d, EEEE", 'pt_BR');
  static String todayDate(DateTime dateTime) =>
      todayWeekDayFormat.format(dateTime);
  static final DateFormat dayMonthDayWeekFormat =
      DateFormat("d 'de' MMM (EEEE)", 'pt_BR');
  static String ticketDay(DateTime dateTime) =>
      dayMonthDayWeekFormat.format(dateTime);
}
