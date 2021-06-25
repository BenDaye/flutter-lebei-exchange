import 'package:flustars/flustars.dart';
import 'package:sentry/sentry.dart';

import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

enum SortType {
  unset,
  symbolAsc,
  symbolDesc,
  priceAsc,
  priceDesc,
  percentageAsc,
  percentageDesc,
  baseVolAsc,
  baseVolDesc,
  quoteVolAsc,
  quoteVolDesc,
  exchangeAsc,
  exchangeDesc,
}

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
    } else if (ticker.last != NumberFormatter.unknownNumberToString) {
      return NumUtil.getDoubleByValueStr(ticker.last);
    } else {
      return null;
    }
  }

  String formatPriceByRate({Ticker? ticker, String? currency, double? currencyRate}) {
    final Ticker? _ticker = ticker ?? this.ticker;
    if (_ticker == null) return NumberFormatter.unknownNumberToString;

    final String _currency = currency ?? this.currency;
    final double _currencyRate = currencyRate ?? this.currencyRate;

    return NumberHelper.getCurrencySymbol(_currency) +
        NumUtil.multiply(
          TickerHelper.getValuablePrice(_ticker) ?? 0,
          _currencyRate,
        ).toStringAsFixed(2);
  }

  static String getVolumeAsFixed(String value, {int fractionDigits = 0}) {
    if (value == NumberFormatter.unknownNumberToString) return value;
    final double? volume = NumUtil.getDoubleByValueStr(value);
    if (volume == null) return value;
    return volume.toStringAsFixed(fractionDigits);
  }

  static List<Ticker> filter(
    List<Ticker>? tickers, {
    String? quote,
    bool? unknown = false,
    bool? margin = false,
    bool? standard = true,
  }) {
    if (tickers == null || tickers.isEmpty) return <Ticker>[];
    List<Ticker> _tickers = List<Ticker>.from(tickers);

    // ignore: unnecessary_raw_strings
    if (unknown == false) _tickers.removeWhere((Ticker t) => t.symbol.contains(RegExp(r'[a-z]')));
    if (standard == false) _tickers.removeWhere((Ticker t) => !t.symbol.contains(RegExp(r'[1-9]\d*[LS]')));
    if (margin == false) _tickers.removeWhere((Ticker t) => t.symbol.contains(RegExp(r'[1-9]\d*[LS]')));

    if (quote != null && quote.isNotEmpty && quote != 'ALL') {
      _tickers = _tickers.where((Ticker t) => t.symbol.endsWith(quote)).toList();
    }

    TickerHelper.sort(_tickers, sortType: SortType.unset);

    return _tickers;
  }

  static void sort(List<Ticker>? tickers, {SortType sortType = SortType.percentageDesc}) {
    if (tickers == null || tickers.isEmpty) return;
    final RegExp sortRegexp = RegExp(
        // ignore: unnecessary_raw_strings
        r'^BTC/|ETH/|DOT/|XRP/|LINK/|BCH/|LTC/|ADA/|EOS/|TRX/|XMR/|IOTA/|DASH/|ETC/|ZEC/|USDC/|PAX/|WBTC/|SHIB/|DOGE/|FIL/');
    try {
      switch (sortType) {
        case SortType.percentageAsc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => (a.percentage.isNaN ? 0 : a.percentage).compareTo(
                b.percentage.isNaN ? 0 : b.percentage,
              ),
            );
          }
          break;
        case SortType.percentageDesc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => (b.percentage.isNaN ? 0 : b.percentage).compareTo(
                a.percentage.isNaN ? 0 : a.percentage,
              ),
            );
          }
          break;
        case SortType.symbolAsc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => a.symbol.compareTo(b.symbol),
            );
          }
          break;
        case SortType.symbolDesc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => b.symbol.compareTo(a.symbol),
            );
          }
          break;
        case SortType.priceAsc:
          {
            tickers.sort(
              (Ticker a, Ticker b) =>
                  (TickerHelper.getValuablePrice(a) ?? 0).compareTo(TickerHelper.getValuablePrice(b) ?? 0),
            );
          }
          break;
        case SortType.priceDesc:
          {
            tickers.sort(
              (Ticker a, Ticker b) =>
                  (TickerHelper.getValuablePrice(b) ?? 0).compareTo(TickerHelper.getValuablePrice(a) ?? 0),
            );
          }
          break;
        case SortType.baseVolAsc:
          {
            tickers.sort(
              (Ticker a, Ticker b) =>
                  NumberFormatter.stringToNumber(a.baseVolume).compareTo(NumberFormatter.stringToNumber(b.baseVolume)),
            );
          }
          break;
        case SortType.baseVolDesc:
          {
            tickers.sort(
              (Ticker a, Ticker b) =>
                  NumberFormatter.stringToNumber(b.baseVolume).compareTo(NumberFormatter.stringToNumber(a.baseVolume)),
            );
          }
          break;
        case SortType.quoteVolAsc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => NumberFormatter.stringToNumber(a.quoteVolume)
                  .compareTo(NumberFormatter.stringToNumber(b.quoteVolume)),
            );
          }
          break;
        case SortType.quoteVolDesc:
          {
            tickers.sort(
              (Ticker a, Ticker b) => NumberFormatter.stringToNumber(b.quoteVolume)
                  .compareTo(NumberFormatter.stringToNumber(a.quoteVolume)),
            );
          }
          break;
        default:
          {
            tickers.sort((Ticker a, Ticker b) {
              if (a.symbol.startsWith(sortRegexp) && !b.symbol.startsWith(sortRegexp)) {
                return -1;
              } else if (!a.symbol.startsWith(sortRegexp) && b.symbol.startsWith(sortRegexp)) {
                return 1;
              } else {
                return a.symbol.compareTo(b.symbol);
              }
            });
          }
          break;
      }
    } catch (err) {
      Sentry.captureException(err);
    }
  }
}
