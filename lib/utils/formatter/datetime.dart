import 'package:flustars/flustars.dart';

class DateTimeFormatter {
  // ignore: non_constant_identifier_names
  static String UNKNOWN_DATE_TIME = DateUtil.formatDateMs(0);

  static String formatDateStr(dynamic value) {
    if (value is String) {
      return DateUtil.formatDateStr(value);
    }
    return DateTimeFormatter.UNKNOWN_DATE_TIME;
  }
}
