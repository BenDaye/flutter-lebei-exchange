import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

class TickerHelper {
  static getValuablePrice(Ticker ticker) {
    if (!ticker.bid.isNaN) {
      return ticker.bid;
    } else if (!ticker.ask.isNaN) {
      return ticker.ask;
    } else if (ticker.last != NumberFormatter.UNKNOWN_NUMBER_TO_STRING) {
      return NumUtil.getNumByValueStr(ticker.last);
    } else {
      return null;
    }
  }
}
