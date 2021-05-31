import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/types/number_display.dart';
import 'package:get/get.dart';

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
}
