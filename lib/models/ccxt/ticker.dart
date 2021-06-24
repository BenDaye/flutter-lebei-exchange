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

  String symbol;
  dynamic info;
  @JsonKey(defaultValue: 0)
  int timestamp;
  @JsonKey(fromJson: DateTimeFormatter.formatDateStr, toJson: CommonFormatter.whatever)
  String datetime;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double high;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double low;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double bid;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String bidVolume;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double ask;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String askVolume;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String vwap;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String open;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String close;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String last;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String previousClose;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String change;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double percentage;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String average;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String baseVolume;
  @JsonKey(fromJson: NumberFormatter.numberToString, toJson: NumberFormatter.stringToNumber)
  String quoteVolume;
}
