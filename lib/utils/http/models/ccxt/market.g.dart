// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Market _$MarketFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'symbol',
    'base',
    'quote',
    'baseId',
    'quoteId'
  ], disallowNullValues: const [
    'id',
    'symbol',
    'base',
    'quote',
    'baseId',
    'quoteId'
  ]);
  return Market(
    json['id'] as String,
    json['symbol'] as String,
    json['base'] as String,
    json['quote'] as String,
    json['baseId'] as String,
    json['quoteId'] as String,
    json['active'] as bool? ?? false,
    (json['taker'] as num?)?.toDouble(),
    (json['maker'] as num?)?.toDouble(),
    json['percentage'] as bool?,
    json['tierBased'] as bool?,
    Precision.fromJson(json['precision'] as Map<String, dynamic>),
    Limits.fromJson(json['limits'] as Map<String, dynamic>),
    json['info'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'base': instance.base,
      'quote': instance.quote,
      'baseId': instance.baseId,
      'quoteId': instance.quoteId,
      'active': instance.active,
      'taker': instance.taker,
      'maker': instance.maker,
      'percentage': instance.percentage,
      'tierBased': instance.tierBased,
      'precision': instance.precision.toJson(),
      'limits': instance.limits.toJson(),
      'info': instance.info,
    };

Precision _$PrecisionFromJson(Map<String, dynamic> json) {
  return Precision(
    (json['price'] as num).toDouble(),
    (json['amount'] as num?)?.toDouble(),
    (json['cost'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$PrecisionToJson(Precision instance) => <String, dynamic>{
      'price': instance.price,
      'amount': instance.amount,
      'cost': instance.cost,
    };

Limits _$LimitsFromJson(Map<String, dynamic> json) {
  return Limits(
    MaxMin.fromJson(json['amount'] as Map<String, dynamic>),
    MaxMin.fromJson(json['price'] as Map<String, dynamic>),
    MaxMin.fromJson(json['cost'] as Map<String, dynamic>),
    json['market'] == null
        ? null
        : MaxMin.fromJson(json['market'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LimitsToJson(Limits instance) => <String, dynamic>{
      'amount': instance.amount,
      'price': instance.price,
      'cost': instance.cost,
      'market': instance.market,
    };

MaxMin _$MaxMinFromJson(Map<String, dynamic> json) {
  return MaxMin(
    (json['max'] as num?)?.toDouble(),
    (json['min'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$MaxMinToJson(MaxMin instance) => <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
    };
