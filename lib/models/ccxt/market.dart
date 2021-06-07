import 'package:flutter_lebei_exchange/utils/formatter/common.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:json_annotation/json_annotation.dart';

part 'market.g.dart';

@JsonSerializable(explicitToJson: true)
class Market {
  @JsonKey(required: true, disallowNullValue: true)
  String id; // 'btcusd',  // string literal for referencing within an exchange
  @JsonKey(required: true, disallowNullValue: true)
  String symbol; // 'BTC/USD', // uppercase string literal of a pair of currencies
  @JsonKey(required: true, disallowNullValue: true)
  String base; // 'BTC',     // uppercase string, unified base currency code, 3 or more letters
  @JsonKey(required: true, disallowNullValue: true)
  String quote; // 'USD',     // uppercase string, unified quote currency code, 3 or more letters
  @JsonKey(required: true, disallowNullValue: true)
  String baseId; // 'btc',     // any string, exchange-specific base currency id
  @JsonKey(required: true, disallowNullValue: true)
  String quoteId; // 'usd',     // any string, exchange-specific quote currency id
  @JsonKey(defaultValue: false)
  bool active; //  true,     // boolean, market status
  double? taker; //  0.002,    // taker fee rate, 0.002 = 0.2%
  double? maker; //  0.0016,   // maker fee rate, 0.0016 = 0.16%
  bool? percentage; //  true,   // whether the taker and maker fee rate is a multiplier or a fixed flat amount
  bool? tierBased; //  false,   // whether the fee depends on your trading tier (your trading volume)
  Precision precision; // number of decimal digits "after the dot"

  Limits limits; // value limits when placing orders on this market
  Map<String, dynamic> info; // the original unparsed market info from the exchange

  Market(
    this.id,
    this.symbol,
    this.base,
    this.quote,
    this.baseId,
    this.quoteId,
    this.active,
    this.taker,
    this.maker,
    this.percentage,
    this.tierBased,
    this.precision,
    this.limits,
    this.info,
  );

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);
  Map<String, dynamic> toJson() => _$MarketToJson(this);

  static Market empty() => Market(
        'id',
        '[symbol]',
        'base',
        'quote',
        'baseId',
        'quoteId',
        true,
        0,
        0,
        true,
        false,
        Precision(8, 8, 8),
        Limits(
          MaxMin(0, 0),
          MaxMin(0, 0),
          MaxMin(0, 0),
          MaxMin(0, 0),
        ),
        {},
      );
}

@JsonSerializable(explicitToJson: true)
class Precision {
  num price; // 8,       // integer or float for TICK_SIZE roundingMode, might be missing if not supplied by the exchange
  num? amount; // 8,      // integer, might be missing if not supplied by the exchange
  num? cost; // 8,        // integer, very few exchanges actually have it

  Precision(
    this.price,
    this.amount,
    this.cost,
  );

  factory Precision.fromJson(Map<String, dynamic> json) => _$PrecisionFromJson(json);
  Map<String, dynamic> toJson() => _$PrecisionToJson(this);
}

@JsonSerializable()
class Limits {
  MaxMin amount;
  MaxMin price;
  MaxMin cost;
  MaxMin? market;

  Limits(
    this.amount,
    this.price,
    this.cost,
    this.market,
  );

  factory Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);
  Map<String, dynamic> toJson() => _$LimitsToJson(this);
}

@JsonSerializable()
class MaxMin {
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double? max;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double? min;

  MaxMin(
    this.max,
    this.min,
  );

  factory MaxMin.fromJson(Map<String, dynamic> json) => _$MaxMinFromJson(json);
  Map<String, dynamic> toJson() => _$MaxMinToJson(this);
}
