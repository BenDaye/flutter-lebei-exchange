// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticker _$TickerFromJson(Map<String, dynamic> json) {
  return Ticker(
    json['symbol'] as String,
    json['info'],
    json['timestamp'] as int? ?? 0,
    DateTimeFormatter.formatDateStr(json['datetime']),
    NumberFormatter.numberToDouble(json['high']),
    NumberFormatter.numberToDouble(json['low']),
    NumberFormatter.numberToDouble(json['bid']),
    NumberFormatter.numberToString(json['bidVolume']),
    NumberFormatter.numberToDouble(json['ask']),
    NumberFormatter.numberToString(json['askVolume']),
    NumberFormatter.numberToString(json['vwap']),
    NumberFormatter.numberToString(json['open']),
    NumberFormatter.numberToString(json['close']),
    NumberFormatter.numberToString(json['last']),
    NumberFormatter.numberToString(json['previousClose']),
    NumberFormatter.numberToString(json['change']),
    NumberFormatter.numberToDouble(json['percentage']),
    NumberFormatter.numberToString(json['average']),
    NumberFormatter.numberToString(json['baseVolume']),
    NumberFormatter.numberToString(json['quoteVolume']),
  );
}

Map<String, dynamic> _$TickerToJson(Ticker instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'info': instance.info,
      'timestamp': instance.timestamp,
      'datetime': CommonFormatter.whatever(instance.datetime),
      'high': CommonFormatter.whatever(instance.high),
      'low': CommonFormatter.whatever(instance.low),
      'bid': CommonFormatter.whatever(instance.bid),
      'bidVolume': NumberFormatter.stringToNumber(instance.bidVolume),
      'ask': CommonFormatter.whatever(instance.ask),
      'askVolume': NumberFormatter.stringToNumber(instance.askVolume),
      'vwap': NumberFormatter.stringToNumber(instance.vwap),
      'open': NumberFormatter.stringToNumber(instance.open),
      'close': NumberFormatter.stringToNumber(instance.close),
      'last': NumberFormatter.stringToNumber(instance.last),
      'previousClose': NumberFormatter.stringToNumber(instance.previousClose),
      'change': NumberFormatter.stringToNumber(instance.change),
      'percentage': CommonFormatter.whatever(instance.percentage),
      'average': NumberFormatter.stringToNumber(instance.average),
      'baseVolume': NumberFormatter.stringToNumber(instance.baseVolume),
      'quoteVolume': NumberFormatter.stringToNumber(instance.quoteVolume),
    };
