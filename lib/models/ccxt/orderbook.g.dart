// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBook _$OrderBookFromJson(Map<String, dynamic> json) {
  return OrderBook(
    (json['bids'] as List<dynamic>)
        .map((e) =>
            (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
        .toList(),
    (json['asks'] as List<dynamic>)
        .map((e) =>
            (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
        .toList(),
    json['symbol'] as String,
    json['timestamp'] as int?,
    json['datetime'] as String?,
    json['nonce'] as int?,
  );
}

Map<String, dynamic> _$OrderBookToJson(OrderBook instance) => <String, dynamic>{
      'bids': instance.bids,
      'asks': instance.asks,
      'symbol': instance.symbol,
      'timestamp': instance.timestamp,
      'datetime': instance.datetime,
      'nonce': instance.nonce,
    };
