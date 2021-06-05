import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency {
  String id; //       'btc',       // string literal for referencing within an exchange
  String code; //     'BTC',       // uppercase unified string literal code the currency
  String name; //     'Bitcoin',   // string, human-readable name, if specified
  bool active; //    true,       // boolean, currency status (tradeable and withdrawable)
  double fee; //       0.123,      // withdrawal fee, flat
  int precision; // 8,          // number of decimal digits "after the dot" (depends on exchange.precisionMode)
  Limits limits; // {              // value limits when placing orders on this market
  Map<String, dynamic>? info; // { ... }, // the original unparsed currency info from the exchange

  Currency(
    this.id,
    this.code,
    this.name,
    this.active,
    this.fee,
    this.precision,
    this.limits,
    this.info,
  );

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Limits {
  MaxMin? amount;
  MaxMin? withdraw;
  MaxMin? deposit;

  Limits(
    this.amount,
    this.withdraw,
    this.deposit,
  );

  factory Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);
  Map<String, dynamic> toJson() => _$LimitsToJson(this);
}