// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response<T> _$ResponseFromJson<T>(Map<String, dynamic> json) {
  return Response<T>(
    json['status'] as int,
    json['message'] as String,
    _Converter<T?>().fromJson(json['data']),
  );
}

Map<String, dynamic> _$ResponseToJson<T>(Response<T> instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': _Converter<T?>().toJson(instance.data),
    };
