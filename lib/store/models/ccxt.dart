import 'package:flutter_lebei_exchange/store/actions/ccxt/fetch_exchanges.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/fetch_markets.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_current_exchange.dart';
import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';
import 'package:redux/redux.dart';

class CcxtModel {
  final String? currentExchangeId;
  final List<String> exchanges;
  final Market? currentMarket;
  final Map<String, Market> markets;

  Function(String) updateExchangeId;
  Function fetchExchanges;
  Function fetchMarkets;

  CcxtModel({
    this.currentExchangeId,
    required this.exchanges,
    this.currentMarket,
    required this.markets,
    required this.updateExchangeId,
    required this.fetchExchanges,
    required this.fetchMarkets,
  });

  static CcxtModel fromStore(Store<AppState> store) => CcxtModel(
        currentExchangeId: store.state.ccxtState.currentExchangeId,
        exchanges: store.state.ccxtState.exchanges,
        currentMarket: store.state.ccxtState.currentMarket,
        markets: store.state.ccxtState.markets,
        updateExchangeId: (String exchangeId) => store.dispatch(UpdateCurrentExchangeAction(exchangeId)),
        fetchExchanges: () => store.dispatch(FetchExchangesAction()),
        fetchMarkets: () => store.dispatch(FetchMarketsAction()),
      );
}
