import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(explicitToJson: true)
class Response<T> {
  Response(
    this.status,
    this.message,
    this.data,
  );

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson<T>(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  int status;
  String message;
  @_Converter()
  T? data;
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    return json as T;
  }

  @override
  Object? toJson(T object) {
    return object as Object;
  }
}
