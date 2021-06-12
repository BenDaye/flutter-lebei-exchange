import 'package:flutter_lebei_exchange/utils/formatter/common.dart';
import 'package:flutter_lebei_exchange/utils/formatter/datetime.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticker.g.dart';

@JsonSerializable()
class Ticker {
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
  Ticker.empty()
      : symbol = '[symbol]',
        info = null,
        timestamp = 0,
        datetime = DateTimeFormatter.UNKNOWN_DATE_TIME,
        high = NumberFormatter.unknownDouble,
        low = NumberFormatter.unknownDouble,
        bid = NumberFormatter.unknownDouble,
        bidVolume = NumberFormatter.unknownNumberToString,
        ask = NumberFormatter.unknownDouble,
        askVolume = NumberFormatter.unknownNumberToString,
        vwap = NumberFormatter.unknownNumberToString,
        open = NumberFormatter.unknownNumberToString,
        close = NumberFormatter.unknownNumberToString,
        last = NumberFormatter.unknownNumberToString,
        previousClose = NumberFormatter.unknownNumberToString,
        change = NumberFormatter.unknownNumberToString,
        percentage = NumberFormatter.unknownDouble,
        average = NumberFormatter.unknownNumberToString,
        baseVolume = NumberFormatter.unknownNumberToString,
        quoteVolume = NumberFormatter.unknownNumberToString;

  factory Ticker.fromJson(Map<String, dynamic> json) => _$TickerFromJson(json);
  Map<String, dynamic> toJson() => _$TickerToJson(this);

  String symbol; // string symbol of the market ('BTC/USD', 'ETH/BTC', ...)
  dynamic info; // { the original non-modified unparsed reply from exchange API },
  @JsonKey(defaultValue: 0)
  int timestamp; // int (64-bit Unix Timestamp in milliseconds since Epoch 1 Jan 1970)
  @JsonKey(fromJson: DateTimeFormatter.formatDateStr, toJson: CommonFormatter.whatever)
  String datetime; // ISO8601 datetime string with milliseconds
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double high; // float, // highest price
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double low; // float, // lowest price
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double bid; // float, // current best bid (buy) price
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String bidVolume; // float, // current best bid (buy) amount (may be missing or undefined)
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double ask; // float, // current best ask (sell) price
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String askVolume; // float, // current best ask (sell) amount (may be missing or undefined)
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String vwap; // float, // volume weighed average price
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String open; // float, // opening price
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String close; // float, // price of last trade (closing price for current period)
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String last; // float, // same as `close`, duplicated for convenience
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String previousClose; // float, // closing price for the previous period
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String change; // float, // absolute change, `last - open`
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double percentage; // float, // relative change, `(change/open) * 100`
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String average; // float, // average price, `(last + open) / 2`
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String baseVolume; // float, // volume of base currency traded for last 24 hours
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String quoteVolume; // float, // volume of quote currency traded for last 24 hours
}
