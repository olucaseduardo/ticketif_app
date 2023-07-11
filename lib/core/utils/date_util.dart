import 'package:intl/intl.dart';

class DateUtil {
  static final DateTime dateTimeNow = DateTime.now();

  static String todayDateRequest(DateTime dateTime) =>
      DateFormat("EEEE", 'pt_BR').format(dateTime);

  static String todayDate(DateTime dateTime) =>
      DateFormat("'Dia' d, EEEE", 'pt_BR').format(dateTime);

  static String ticketDay(DateTime dateTime) =>
      DateFormat("d 'de' MMM (EEEE)", 'pt_BR').format(dateTime);

  static String getDateStr(DateTime dateTime) =>
      DateFormat("dd/MM/yyyy").format(dateTime);

  static String getDateUSStr(DateTime dateTime) =>
      DateFormat("yyyy-MM-dd").format(dateTime);

  static bool checkTodayDate(DateTime dateTime) =>
      (dateTime.day == dateTimeNow.day) &&
      (dateTime.month == dateTimeNow.month) &&
      (dateTime.year == dateTimeNow.year);
}
