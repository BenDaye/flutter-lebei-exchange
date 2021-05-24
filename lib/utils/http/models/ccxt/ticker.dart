import 'package:json_annotation/json_annotation.dart';

part 'ticker.g.dart';

@JsonSerializable()
class Ticker {
  String symbol; // string symbol of the market ('BTC/USD', 'ETH/BTC', ...)
  Map<String, dynamic> info; // { the original non-modified unparsed reply from exchange API },
  int? timestamp; // int (64-bit Unix Timestamp in milliseconds since Epoch 1 Jan 1970)
  String datetime; // ISO8601 datetime string with milliseconds
  double? high; // float, // highest price
  double? low; // float, // lowest price
  double? bid; // float, // current best bid (buy) price
  dynamic bidVolume; // float, // current best bid (buy) amount (may be missing or undefined)
  double? ask; // float, // current best ask (sell) price
  dynamic askVolume; // float, // current best ask (sell) amount (may be missing or undefined)
  double? vwap; // float, // volume weighed average price
  double? open; // float, // opening price
  double? close; // float, // price of last trade (closing price for current period)
  double? last; // float, // same as `close`, duplicated for convenience
  double? previousClose; // float, // closing price for the previous period
  double? change; // float, // absolute change, `last - open`
  double? percentage; // float, // relative change, `(change/open) * 100`
  double? average; // float, // average price, `(last + open) / 2`
  double? baseVolume; // float, // volume of base currency traded for last 24 hours
  double? quoteVolume; // float, // volume of quote currency traded for last 24 hours

  Ticker(
    this.symbol,
    this.info,
    this.timestamp,
    this.datetime,
    this.high,
    this.low,
    this.bid,
    this.bidVolume,
    this.ask,
    this.askVolume,
    this.vwap,
    this.open,
    this.close,
    this.last,
    this.previousClose,
    this.change,
    this.percentage,
    this.average,
    this.baseVolume,
    this.quoteVolume,
  );

  factory Ticker.fromJson(Map<String, dynamic> json) => _$TickerFromJson(json);
  Map<String, dynamic> toJson() => _$TickerToJson(this);

  static Ticker empty() => Ticker(
        '[symbol]',
        {},
        0,
        'datetime',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
}
