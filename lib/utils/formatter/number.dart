import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

class NumberFormatter {
  static const String UNKNOWN_NUMBER_TO_STRING = '--';
  static const double UNKNOWN_DOUBLE = double.nan;

  static String numberToString(dynamic value) {
    if (value is String) return value;
    if (value is num) {
      String valueString = value.toString();
      if (value.abs().isLowerThan(1)) {
        if (!valueString.contains('e-')) return valueString;

        final ne = valueString.split('e-');
        final n = ne[0].replaceAll('.', '');
        final e = int.parse(ne[1]);
        if (e.isGreaterThan(0)) {
          return (value.isNegative ? '-' : '') +
              '0.' +
              List.filled(e - 1, '0').join('') +
              n.substring(value.isNegative ? 1 : 0);
        } else {
          return ne[0];
        }
      } else {
        if (!valueString.contains('e')) return valueString;

        final ne = valueString.split('e');
        final n = ne[0].split('.');
        int e = int.parse(ne[1]);

        if (n.length == 2) {
          e -= n[1].length;
        }

        if (e.isGreaterThan(-1)) {
          return n.join('') + List.filled(e, '0').join('');
        } else {
          final m = n.join('').split('');
          m.insert(m.length - e, '.');
          return m.join('');
        }
      }
    }
    return NumberFormatter.UNKNOWN_NUMBER_TO_STRING;
  }

  static num stringToNumber(dynamic value) {
    if (value is num) return value;
    if (value is String) {
      return NumUtil.getNumByValueStr(value) ?? UNKNOWN_DOUBLE;
    }
    return UNKNOWN_DOUBLE;
  }

  static double numberToDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return NumUtil.getDoubleByValueStr(value) ?? UNKNOWN_DOUBLE;
    }
    return UNKNOWN_DOUBLE;
  }
}
