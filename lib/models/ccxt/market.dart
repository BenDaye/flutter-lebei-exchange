import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_lebei_exchange/utils/formatter/common.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

part 'market.g.dart';

@JsonSerializable(explicitToJson: true)
class Market {
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

  Market.empty()
      : id = 'id',
        symbol = '[symbol]',
        base = 'base',
        quote = 'quote',
        baseId = 'baseId',
        quoteId = 'quoteId',
        active = true,
        taker = 0,
        maker = 0,
        percentage = true,
        tierBased = false,
        precision = Precision(8, 8, 8),
        limits = Limits(
          MaxMin(0, 0),
          MaxMin(0, 0),
          MaxMin(0, 0),
          MaxMin(0, 0),
        ),
        info = null;

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);
  Map<String, dynamic> toJson() => _$MarketToJson(this);

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
  dynamic info; // the original unparsed market info from the exchange
}

@JsonSerializable(explicitToJson: true)
class Precision {
  Precision(
    this.price,
    this.amount,
    this.cost,
  );

  factory Precision.fromJson(Map<String, dynamic> json) => _$PrecisionFromJson(json);
  Map<String, dynamic> toJson() => _$PrecisionToJson(this);

  num price; // 8,       // integer or float for tickSize roundingMode, might be missing if not supplied by the exchange
  num? amount; // 8,      // integer, might be missing if not supplied by the exchange
  num? cost; // 8,        // integer, very few exchanges actually have it
}

@JsonSerializable()
class Limits {
  Limits(
    this.amount,
    this.price,
    this.cost,
    this.market,
  );

  factory Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);
  Map<String, dynamic> toJson() => _$LimitsToJson(this);

  MaxMin amount;
  MaxMin price;
  MaxMin cost;
  MaxMin? market;
}

@JsonSerializable()
class MaxMin {
  MaxMin(
    this.max,
    this.min,
  );

  factory MaxMin.fromJson(Map<String, dynamic> json) => _$MaxMinFromJson(json);
  Map<String, dynamic> toJson() => _$MaxMinToJson(this);

  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double? max;
  @JsonKey(fromJson: NumberFormatter.numberToDouble, toJson: CommonFormatter.whatever)
  double? min;
}
