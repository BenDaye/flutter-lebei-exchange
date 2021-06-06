import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/models/ccxt/exchange.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/types/number_display.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class NumberHelper {
  NumberHelper({this.currencyRate = 1.0, this.locale});
  double currencyRate;
  Locale? locale;

  bool get isChinese => <Locale>[Locale('zh', 'CN')].any((e) => e == locale);

  NumberDisplay getNumberDisplay(num? value, {double? currencyRate, bool? isChinese}) {
    if (value == null || value.isNaN || value.isInfinite) return NumberDisplay('--', '0.0', '');

    final _currencyRate = currencyRate ?? this.currencyRate;
    final _isChinese = isChinese ?? this.isChinese;
    final _value = NumUtil.multiply(value.toDouble(), _currencyRate);
    final _valueAbs = _value.abs();

    if (_isChinese) {
      if (_valueAbs.isGreaterThan(1000 * 1000 * 1000 * 1000))
        return NumberDisplay(
          '${NumUtil.divide(_value, 1000 * 1000 * 1000 * 1000).toStringAsFixed(2)}' + 'Common.Unit.ZHAO'.tr,
          NumUtil.divide(_value, 1000 * 1000 * 1000 * 1000).toStringAsFixed(2),
          'ZHAO',
        );
      else if (_valueAbs.isGreaterThan(1000 * 1000 * 100))
        return NumberDisplay(
          '${NumUtil.divide(_value, 1000 * 1000 * 100).toStringAsFixed(2)}' + 'Common.Unit.YI'.tr,
          NumUtil.divide(_value, 1000 * 1000 * 100).toStringAsFixed(2),
          'YI',
        );
      else if (_valueAbs.isGreaterThan(1000 * 10))
        return NumberDisplay(
          '${NumUtil.divide(_value, 1000 * 10).toStringAsFixed(2)}' + 'Common.Unit.WAN'.tr,
          NumUtil.divide(_value, 1000 * 10).toStringAsFixed(2),
          'WAN',
        );
      else if (_valueAbs.isGreaterThan(1000))
        return NumberDisplay(
          '${NumUtil.divide(_value, 1000).toStringAsFixed(2)}' + 'Common.Unit.QIAN'.tr,
          NumUtil.divide(_value, 1000).toStringAsFixed(2),
          'QIAN',
        );
      else
        return NumberDisplay(
          '${_value.toStringAsFixed(2)}',
          _value.toStringAsFixed(2),
          '',
        );
    }

    if (_valueAbs.isGreaterThan(1000 * 1000 * 1000 * 1000))
      return NumberDisplay(
        '${NumUtil.divide(_value, 1000 * 1000 * 1000 * 1000).toStringAsFixed(2)}T',
        NumUtil.divide(_value, 1000 * 1000 * 1000 * 1000).toStringAsFixed(2),
        'T',
      );
    else if (_valueAbs.isGreaterThan(1000 * 1000 * 1000))
      return NumberDisplay(
        '${NumUtil.divide(_value, 1000 * 1000 * 1000).toStringAsFixed(2)}B',
        NumUtil.divide(_value, 1000 * 1000 * 1000).toStringAsFixed(2),
        'B',
      );
    else if (_valueAbs.isGreaterThan(1000 * 1000))
      return NumberDisplay(
        '${NumUtil.divide(_value, 1000 * 1000).toStringAsFixed(2)}M',
        NumUtil.divide(_value, 1000 * 1000).toStringAsFixed(2),
        'M',
      );
    else if (_valueAbs.isGreaterThan(1000))
      return NumberDisplay(
        '${NumUtil.divide(_value, 1000).toStringAsFixed(2)}k',
        NumUtil.divide(_value, 1000).toStringAsFixed(2),
        'k',
      );
    else
      return NumberDisplay(
        '${_value.toStringAsFixed(2)}',
        _value.toStringAsFixed(2),
        '',
      );
  }

  static String getCurrencySymbol(String code) {
    switch (code) {
      case 'CNY':
        return '¥';
      case 'USD':
        return '\$';
      default:
        return code;
    }
  }

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
    return '--';
  }

  static String decimalToPrecision(
    dynamic value,
    num precision, {
    PrecisionMode precisionMode = PrecisionMode.DECIMAL_PLACES,
    PaddingMode paddingMode = PaddingMode.NO_PADDING,
  }) {
    String _value = '--';
    if (value is String) {
      if (value.isEmpty) return _value;
      num? _valueNumber = NumUtil.getNumByValueStr(value);
      if (_valueNumber is num) {
        return _decimalToPrecision(
          _valueNumber,
          precision,
          precisionMode: precisionMode,
          paddingMode: paddingMode,
        );
      }
      return _value;
    } else if (value is num) {
      return _decimalToPrecision(
        value,
        precision,
        precisionMode: precisionMode,
        paddingMode: paddingMode,
      );
    } else {
      return _value;
    }
  }

  static String _decimalToPrecision(
    num value,
    num precision, {
    PrecisionMode precisionMode = PrecisionMode.DECIMAL_PLACES,
    PaddingMode paddingMode = PaddingMode.NO_PADDING,
  }) {
    String _value = '--';
    try {
      switch (precisionMode) {
        case PrecisionMode.DECIMAL_PLACES:
          {
            _value = value.toStringAsFixed(precision.toInt());
            // if (paddingMode == PaddingMode.NO_PADDING) {
            //   _value = NumberHelper.numberToString(NumUtil.getNumByValueStr(_value));
            // }
          }
          break;
        case PrecisionMode.SIGNIFICANT_DIGITS:
          {
            if (precision.toInt().isGreaterThan(numberToString(value).split('.').join('').length)) {
              _value = value.toStringAsFixed(precision.toInt());
              // if (paddingMode == PaddingMode.NO_PADDING) {
              //   _value = NumberHelper.numberToString(NumUtil.getNumByValueStr(_value));
              // }
            } else {
              _value = value.toStringAsPrecision(precision.toInt());
            }
          }
          break;
        case PrecisionMode.TICK_SIZE:
          {
            if (precision.isGreaterThan(0)) {
              _value = numberToString(value - (value % precision) + precision);
              if (paddingMode == PaddingMode.PAD_WITH_ZERO && numberToString(precision).split('.').length == 2) {
                _value = NumUtil.getDoubleByValueStr(_value)!
                    .toStringAsFixed(numberToString(precision).split('.')[1].length);
              }
            }
          }
          break;
        default:
          break;
      }
    } catch (err) {
      Sentry.captureException(err);
    }
    return _value;
  }
}
