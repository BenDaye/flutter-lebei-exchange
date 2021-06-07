import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

class TickerHelper {
  TickerHelper({
    this.ticker,
    this.currencyRate = 1.0,
    this.currency = 'USD',
  });

  Ticker? ticker;
  String currency;
  double currencyRate;

  static double? getValuablePrice(Ticker ticker) {
    if (!ticker.bid.isNaN) {
      return ticker.bid;
    } else if (!ticker.ask.isNaN) {
      return ticker.ask;
    } else if (ticker.last != NumberFormatter.UNKNOWN_NUMBER_TO_STRING) {
      return NumUtil.getDoubleByValueStr(ticker.last);
    } else {
      return null;
    }
  }

  String formatPriceByRate({Ticker? ticker, String? currency, double? currencyRate}) {
    final _ticker = ticker ?? this.ticker;
    if (_ticker == null) return NumberFormatter.UNKNOWN_NUMBER_TO_STRING;

    final _currency = currency ?? this.currency;
    final _currencyRate = currencyRate ?? this.currencyRate;

    return NumberHelper.getCurrencySymbol(_currency) +
        NumUtil.multiply(
          TickerHelper.getValuablePrice(_ticker) ?? 0,
          _currencyRate,
        ).toStringAsFixed(2);
  }

  static String getVolumeAsFixed(String value, {int fractionDigits = 0}) {
    if (value == NumberFormatter.UNKNOWN_NUMBER_TO_STRING) return value;
    double? volume = NumUtil.getDoubleByValueStr(value);
    if (volume == null) return value;
    return volume.toStringAsFixed(fractionDigits);
  }
}
