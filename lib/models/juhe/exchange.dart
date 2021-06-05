import 'package:json_annotation/json_annotation.dart';

part 'exchange.g.dart';

@JsonSerializable(explicitToJson: true)
class Code {
  String code;
  String name;

  Code(
    this.code,
    this.name,
  );

  factory Code.fromJson(Map<String, dynamic> json) => _$CodeFromJson(json);
  Map<String, dynamic> toJson() => _$CodeToJson(this);
}

@JsonSerializable()
class Rate {
  @JsonKey(name: 'currencyF')
  String from; // "CNY",
  @JsonKey(name: 'currencyF_Name')
  String fromName; // "人民币",
  @JsonKey(name: 'currencyT')
  String to; // "USD",
  @JsonKey(name: 'currencyT_Name')
  String toName; // "美元",
  @JsonKey(name: 'currencyFD')
  String unit; // "1",
  String exchange; // "0.1570",
  String result; // "0.1570",
  String updateTime; // "2021-05-31 00:17:37"

  Rate(
    this.from,
    this.fromName,
    this.to,
    this.toName,
    this.unit,
    this.exchange,
    this.result,
    this.updateTime,
  );

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
  Map<String, dynamic> toJson() => _$RateToJson(this);
}
