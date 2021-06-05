// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) {
  return Trade(
    json['info'] as Map<String, dynamic>?,
    json['id'] as String,
    json['timestamp'] as int?,
    json['datetime'] as String?,
    json['symbol'] as String,
    json['order'] as String?,
    json['type'],
    json['side'] as String,
    json['takerOrMaker'] as String?,
    (json['price'] as num).toDouble(),
    (json['amount'] as num).toDouble(),
    (json['cost'] as num).toDouble(),
    json['fee'] == null
        ? null
        : Fee.fromJson(json['fee'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'info': instance.info,
      'id': instance.id,
      'timestamp': instance.timestamp,
      'datetime': instance.datetime,
      'symbol': instance.symbol,
      'order': instance.order,
      'type': instance.type,
      'side': instance.side,
      'takerOrMaker': instance.takerOrMaker,
      'price': instance.price,
      'amount': instance.amount,
      'cost': instance.cost,
      'fee': instance.fee,
    };

Fee _$FeeFromJson(Map<String, dynamic> json) {
  return Fee(
    (json['cost'] as num).toDouble(),
    json['currency'] as String,
    (json['rate'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'cost': instance.cost,
      'currency': instance.currency,
      'rate': instance.rate,
    };
