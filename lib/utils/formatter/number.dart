import 'package:flustars/flustars.dart' show NumUtil;
import 'package:get/get.dart';

class NumberFormatter {
  static const String unknownNumberToString = '--';
  static const double unknownDouble = double.nan;

  static String numberToString(dynamic value) {
    if (value is String) return value;
    if (value is num) {
      if (value.isNaN) return NumberFormatter.unknownNumberToString;
      final String valueString = value.toString();
      if (value.abs().isLowerThan(1)) {
        if (!valueString.contains('e-')) return valueString;

        final List<String> ne = valueString.split('e-');
        final String n = ne[0].replaceAll('.', '');
        final int e = int.parse(ne[1]);
        if (e.isGreaterThan(0)) {
          return '${value.isNegative ? '-' : ''}0.${List<String>.filled(e - 1, '0').join()}${n.substring(value.isNegative ? 1 : 0)}';
        } else {
          return ne[0];
        }
      } else {
        if (!valueString.contains('e')) return valueString;

        final List<String> ne = valueString.split('e');
        final List<String> n = ne[0].split('.');
        int e = int.parse(ne[1]);

        if (n.length == 2) {
          e -= n[1].length;
        }

        if (e.isGreaterThan(-1)) {
          return n.join() + List<String>.filled(e, '0').join();
        } else {
          final List<String> m = n.join().split('');
          m.insert(m.length - e, '.');
          return m.join();
        }
      }
    }
    return NumberFormatter.unknownNumberToString;
  }

  static num stringToNumber(dynamic value) {
    if (value is num) return value;
    if (value is String) {
      return NumUtil.getNumByValueStr(value) ?? unknownDouble;
    }
    return unknownDouble;
  }

  static double numberToDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return NumUtil.getDoubleByValueStr(value) ?? unknownDouble;
    }
    return unknownDouble;
  }
}
