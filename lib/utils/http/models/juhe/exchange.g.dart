// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Code _$CodeFromJson(Map<String, dynamic> json) {
  return Code(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CodeToJson(Code instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

Rate _$RateFromJson(Map<String, dynamic> json) {
  return Rate(
    json['currencyF'] as String,
    json['currencyF_Name'] as String,
    json['currencyT'] as String,
    json['currencyT_Name'] as String,
    json['currencyFD'] as String,
    json['exchange'] as String,
    json['result'] as String,
    json['updateTime'] as String,
  );
}

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'currencyF': instance.from,
      'currencyF_Name': instance.fromName,
      'currencyT': instance.to,
      'currencyT_Name': instance.toName,
      'currencyFD': instance.unit,
      'exchange': instance.exchange,
      'result': instance.result,
      'updateTime': instance.updateTime,
    };
