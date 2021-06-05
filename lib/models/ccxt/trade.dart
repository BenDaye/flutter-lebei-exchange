import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
  Map<String, dynamic>? info; // { ... },                    // the original decoded JSON as is
  String id; // '12345-67890:09876/54321',  // string trade id
  int? timestamp; // 1502962946216,              // Unix timestamp in milliseconds
  String? datetime; // '2017-08-17 12:42:48.000',  // ISO8601 datetime with milliseconds
  String symbol; // 'ETH/BTC',                  // symbol
  String? order; // '12345-67890:09876/54321',  // string order id or undefined/None/null
  dynamic type; // 'limit',                    // order type, 'market', 'limit' or undefined/None/null
  String side; // 'buy',                      // direction of the trade, 'buy' or 'sell'
  String? takerOrMaker; // 'taker',                    // string, 'taker' or 'maker'
  double price; // 0.06917684,                 // float price in quote currency
  double amount; // 1.5,                        // amount of base currency
  double cost; // 0.10376526,                 // total cost, `price * amount`,
  Fee? fee; // {},                         // provided by exchange or calculated by ccxt

  Trade(
    this.info,
    this.id,
    this.timestamp,
    this.datetime,
    this.symbol,
    this.order,
    this.type,
    this.side,
    this.takerOrMaker,
    this.price,
    this.amount,
    this.cost,
    this.fee,
  );

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);

  static Trade empty() => Trade(
        {},
        '[id]',
        0,
        '[datetime]',
        '[symbol]',
        '[order]',
        '[type]',
        '[side]',
        '[takerOrMaker]',
        0,
        0,
        0,
        Fee.empty(),
      );
}

@JsonSerializable()
class Fee {
  double cost; //  0.0015,                        // float
  String currency; // 'ETH',                      // usually base currency for buys, quote currency for sells
  double rate; // 0.002,                          // the fee rate (if available)

  Fee(
    this.cost,
    this.currency,
    this.rate,
  );

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);
  Map<String, dynamic> toJson() => _$FeeToJson(this);

  static Fee empty() => Fee(0, '[currency]', 0);
}
