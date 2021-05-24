import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';

class CcxtState {
  final String? currentExchangeId;
  final List<String> exchanges;
  final Market? currentMarket;
  final Map<String, Market> markets;

  CcxtState({
    this.currentExchangeId,
    this.exchanges = const [],
    this.currentMarket,
    this.markets = const {},
  });

  CcxtState copyWith({
    String? currentExchangeId,
    List<String>? exchanges,
    Market? currentMarket,
    Map<String, Market>? markets,
  }) =>
      CcxtState(
        currentExchangeId: currentExchangeId ?? this.currentExchangeId,
        exchanges: exchanges ?? this.exchanges,
        currentMarket: currentMarket ?? this.currentMarket,
        markets: markets ?? this.markets,
      );

  static CcxtState initialState() => CcxtState(
        currentExchangeId: null,
        exchanges: [],
        currentMarket: null,
        markets: {},
      );
}
