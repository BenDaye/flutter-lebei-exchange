import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:sentry/sentry.dart';

enum SortType {
  UnSet,
  SymbolAsc,
  SymbolDesc,
  PriceAsc,
  PriceDesc,
  PercentageAsc,
  PercentageDesc,
  BaseVolAsc,
  BaseVolDesc,
  QuoteVolAsc,
  QuoteVolDesc,
  ExchangeAsc,
  ExchangeDesc,
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

  static List<Ticker> filter(
    List<Ticker>? tickers, {
    String? quote,
    bool? unknown = false,
    bool? margin = false,
    bool? standard = true,
  }) {
    if (tickers == null || tickers.isEmpty) return [];
    List<Ticker> _tickers = List<Ticker>.from(tickers);

    if (unknown == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r'[a-z]')));
    if (standard == false) _tickers.removeWhere((t) => !t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));
    if (margin == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));

    if (quote != null && quote.isNotEmpty && quote != 'ALL')
      _tickers = _tickers.where((t) => t.symbol.endsWith(quote)).toList();

    TickerHelper.sort(_tickers, sortType: SortType.UnSet);

    return _tickers;
  }

  static sort(List<Ticker>? tickers, {SortType sortType = SortType.PercentageDesc}) {
    if (tickers == null || tickers.isEmpty) return;
    final sortRegexp = new RegExp(
        r'^BTC/|ETH/|DOT/|XRP/|LINK/|BCH/|LTC/|ADA/|EOS/|TRX/|XMR/|IOTA/|DASH/|ETC/|ZEC/|USDC/|PAX/|WBTC/|SHIB/|DOGE/|FIL/');
    try {
      switch (sortType) {
        case SortType.PercentageAsc:
          {
            tickers.sort(
              (a, b) => (a.percentage.isNaN ? 0 : a.percentage).compareTo(
                (b.percentage.isNaN ? 0 : b.percentage),
              ),
            );
          }
          break;
        case SortType.PercentageDesc:
          {
            tickers.sort(
              (a, b) => (b.percentage.isNaN ? 0 : b.percentage).compareTo(
                (a.percentage.isNaN ? 0 : a.percentage),
              ),
            );
          }
          break;
        case SortType.SymbolAsc:
          {
            tickers.sort(
              (a, b) => a.symbol.compareTo(b.symbol),
            );
          }
          break;
        case SortType.SymbolDesc:
          {
            tickers.sort(
              (a, b) => b.symbol.compareTo(a.symbol),
            );
          }
          break;
        case SortType.PriceAsc:
          {
            tickers.sort(
              (a, b) => (TickerHelper.getValuablePrice(a) ?? 0).compareTo((TickerHelper.getValuablePrice(b) ?? 0)),
            );
          }
          break;
        case SortType.PriceDesc:
          {
            tickers.sort(
              (a, b) => (TickerHelper.getValuablePrice(b) ?? 0).compareTo((TickerHelper.getValuablePrice(a) ?? 0)),
            );
          }
          break;
        case SortType.BaseVolAsc:
          {
            tickers.sort(
              (a, b) =>
                  NumberFormatter.stringToNumber(a.baseVolume).compareTo(NumberFormatter.stringToNumber(b.baseVolume)),
            );
          }
          break;
        case SortType.BaseVolDesc:
          {
            tickers.sort(
              (a, b) =>
                  NumberFormatter.stringToNumber(b.baseVolume).compareTo(NumberFormatter.stringToNumber(a.baseVolume)),
            );
          }
          break;
        case SortType.QuoteVolAsc:
          {
            tickers.sort(
              (a, b) => NumberFormatter.stringToNumber(a.quoteVolume)
                  .compareTo(NumberFormatter.stringToNumber(b.quoteVolume)),
            );
          }
          break;
        case SortType.QuoteVolDesc:
          {
            tickers.sort(
              (a, b) => NumberFormatter.stringToNumber(b.quoteVolume)
                  .compareTo(NumberFormatter.stringToNumber(a.quoteVolume)),
            );
          }
          break;
        default:
          {
            tickers.sort((a, b) {
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
