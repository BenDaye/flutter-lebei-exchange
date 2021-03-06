import 'package:json_annotation/json_annotation.dart';

part 'orderbook.g.dart';

@JsonSerializable()
class OrderBook {
  OrderBook(
    this.bids,
    this.asks,
    this.symbol,
    this.timestamp,
    this.datetime,
    this.nonce,
  );
  OrderBook.empty()
      : bids = <List<double>>[],
        asks = <List<double>>[],
        symbol = '[symbol]',
        timestamp = 0,
        datetime = '[datetime]',
        nonce = 0;

  factory OrderBook.fromJson(Map<String, dynamic> json) => _$OrderBookFromJson(json);
  Map<String, dynamic> toJson() => _$OrderBookToJson(this);

  List<List<double>> bids;
  List<List<double>> asks;
  String symbol; // 'ETH/BTC', // a unified market symbol
  int? timestamp; // 1499280391811, // Unix Timestamp in milliseconds (seconds * 1000)
  String? datetime; // '2017-07-05T18:47:14.692Z', // ISO8601 datetime string with milliseconds
  int? nonce; // 1499280391811, // an increasing unique identifier of the orderbook snapshot
}
