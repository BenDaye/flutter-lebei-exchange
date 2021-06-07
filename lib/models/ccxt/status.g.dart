// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    Status._statusFromJson(json['status']),
    json['updated'] as int?,
    json['eta'],
    json['url'],
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'status': Status._statusToJson(instance.status),
      'updated': instance.updated,
      'eta': instance.eta,
      'url': instance.url,
    };
