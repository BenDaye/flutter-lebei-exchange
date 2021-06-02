// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticker _$TickerFromJson(Map<String, dynamic> json) {
  return Ticker(
    json['symbol'] as String,
    json['info'],
    json['timestamp'] as int?,
    json['datetime'] as String,
    (json['high'] as num?)?.toDouble(),
    (json['low'] as num?)?.toDouble(),
    (json['bid'] as num?)?.toDouble(),
    json['bidVolume'],
    (json['ask'] as num?)?.toDouble(),
    json['askVolume'],
    (json['vwap'] as num?)?.toDouble(),
    (json['open'] as num?)?.toDouble(),
    (json['close'] as num?)?.toDouble(),
    (json['last'] as num?)?.toDouble(),
    (json['previousClose'] as num?)?.toDouble(),
    Ticker._changeFromJson(json['change']),
    (json['percentage'] as num?)?.toDouble(),
    (json['average'] as num?)?.toDouble(),
    (json['baseVolume'] as num?)?.toDouble(),
    (json['quoteVolume'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$TickerToJson(Ticker instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'info': instance.info,
      'timestamp': instance.timestamp,
      'datetime': instance.datetime,
      'high': instance.high,
      'low': instance.low,
      'bid': instance.bid,
      'bidVolume': instance.bidVolume,
      'ask': instance.ask,
      'askVolume': instance.askVolume,
      'vwap': instance.vwap,
      'open': instance.open,
      'close': instance.close,
      'last': instance.last,
      'previousClose': instance.previousClose,
      'change': instance.change,
      'percentage': instance.percentage,
      'average': instance.average,
      'baseVolume': instance.baseVolume,
      'quoteVolume': instance.quoteVolume,
    };
