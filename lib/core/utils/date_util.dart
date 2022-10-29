import 'package:intl/intl.dart';

class DateUtil{
  static final DateFormat todayWeekDayFormat = DateFormat("'Dia' d, EEEE", 'pt_BR');
  static String todayDate(DateTime dateTime) => todayWeekDayFormat.format(dateTime);
}