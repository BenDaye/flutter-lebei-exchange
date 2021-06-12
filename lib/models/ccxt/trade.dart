import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
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

  Trade.empty()
      : info = null,
        id = '[id]',
        timestamp = 0,
        datetime = '[datetime]',
        symbol = '[symbol]',
        order = '[order]',
        type = '[type]',
        side = '[side]',
        takerOrMaker = '[takerOrMaker]',
        price = 0,
        amount = 0,
        cost = 0,
        fee = Fee.empty();

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);

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

}

@JsonSerializable()
class Fee {
  Fee(
    this.cost,
    this.currency,
    this.rate,
  );
  Fee.empty()
      : cost = 0,
        currency = '[currency]',
        rate = 0;

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);
  Map<String, dynamic> toJson() => _$FeeToJson(this);

  double cost; //  0.0015,                        // float
  String currency; // 'ETH',                      // usually base currency for buys, quote currency for sells
  double rate; // 0.002,                          // the fee rate (if available)
}
