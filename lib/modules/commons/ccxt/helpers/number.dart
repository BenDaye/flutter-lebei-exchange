import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/models/ccxt/exchange.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/types/number_display.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class NumberHelper {
  NumberHelper({this.currencyRate = 1.0, this.locale});
  double currencyRate;
  Locale? locale;

  bool get isChinese => <Locale>[Locale('zh', 'CN')].any((e) => e == locale);

  NumberDisplay getNumberDisplay(dynamic value, {double? currencyRate, bool? isChinese}) {
    if (value == NumberFormatter.UNKNOWN_NUMBER_TO_STRING || value == null || !(value is String))
      return NumberDisplay(NumberFormatter.UNKNOWN_NUMBER_TO_STRING, '0.0', '');
    double valueToDouble = NumUtil.getDoubleByValueStr(value) ?? double.nan;
    if (valueToDouble.isNaN || valueToDouble.isInfinite)
      return NumberDisplay(NumberFormatter.UNKNOWN_NUMBER_TO_STRING, '0.0', '');

    final _currencyRate = currencyRate ?? this.currencyRate;
    final _isChinese = isChinese ?? this.isChinese;
    final _value = NumUtil.multiply(valueToDouble, _currencyRate);
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

  static String decimalToPrecision(
    dynamic value,
    num precision, {
    PrecisionMode precisionMode = PrecisionMode.DECIMAL_PLACES,
    PaddingMode paddingMode = PaddingMode.NO_PADDING,
  }) {
    String _value = NumberFormatter.UNKNOWN_NUMBER_TO_STRING;
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
    String _value = NumberFormatter.UNKNOWN_NUMBER_TO_STRING;
    if (value.isNaN) return _value;
    try {
      switch (precisionMode) {
        case PrecisionMode.DECIMAL_PLACES:
          {
            _value = value.toStringAsFixed(precision.toInt());
            // if (paddingMode == PaddingMode.NO_PADDING) {
            //   _value = NumberFormatter.numberToString(NumUtil.getNumByValueStr(_value));
            // }
          }
          break;
        case PrecisionMode.SIGNIFICANT_DIGITS:
          {
            if (precision.toInt().isGreaterThan(NumberFormatter.numberToString(value).split('.').join('').length)) {
              _value = value.toStringAsFixed(precision.toInt());
              // if (paddingMode == PaddingMode.NO_PADDING) {
              //   _value = NumberFormatter.numberToString(NumUtil.getNumByValueStr(_value));
              // }
            } else {
              _value = value.toStringAsPrecision(precision.toInt());
            }
          }
          break;
        case PrecisionMode.TICK_SIZE:
          {
            if (precision.isGreaterThan(0)) {
              _value = NumberFormatter.numberToString(value - (value % precision) + precision);
              if (paddingMode == PaddingMode.PAD_WITH_ZERO &&
                  NumberFormatter.numberToString(precision).split('.').length == 2) {
                _value = NumUtil.getDoubleByValueStr(_value)!
                    .toStringAsFixed(NumberFormatter.numberToString(precision).split('.')[1].length);
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
