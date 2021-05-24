// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    json['id'] as String,
    json['code'] as String,
    json['name'] as String,
    json['active'] as bool,
    (json['fee'] as num).toDouble(),
    json['precision'] as int,
    Limits.fromJson(json['limits'] as Map<String, dynamic>),
    json['info'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'active': instance.active,
      'fee': instance.fee,
      'precision': instance.precision,
      'limits': instance.limits,
      'info': instance.info,
    };

Limits _$LimitsFromJson(Map<String, dynamic> json) {
  return Limits(
    json['amount'] == null
        ? null
        : MaxMin.fromJson(json['amount'] as Map<String, dynamic>),
    json['withdraw'] == null
        ? null
        : MaxMin.fromJson(json['withdraw'] as Map<String, dynamic>),
    json['deposit'] == null
        ? null
        : MaxMin.fromJson(json['deposit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LimitsToJson(Limits instance) => <String, dynamic>{
      'amount': instance.amount,
      'withdraw': instance.withdraw,
      'deposit': instance.deposit,
    };
