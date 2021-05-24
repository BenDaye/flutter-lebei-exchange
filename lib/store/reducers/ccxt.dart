import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_current_exchange.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_current_market.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_exchanges.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_markets.dart';
import 'package:flutter_lebei_exchange/store/ccxt.dart';
import 'package:redux/redux.dart';

final ccxtReducers = combineReducers<CcxtState>([
  TypedReducer<CcxtState, UpdateCurrentExchangeAction>(_updateCurrentExchange),
  TypedReducer<CcxtState, UpdateExchangesAction>(_updateExchanges),
  TypedReducer<CcxtState, UpdateCurrentMarketAction>(_updateCurrentMarket),
  TypedReducer<CcxtState, UpdateMarketsAction>(_updateMarkets),
]);

CcxtState _updateCurrentExchange(CcxtState state, UpdateCurrentExchangeAction action) {
  return state.copyWith(currentExchangeId: action.exchangeId);
}

CcxtState _updateExchanges(CcxtState state, UpdateExchangesAction action) {
  if (ObjectUtil.isEmptyList(action.exchanges)) {
    return state;
  }
  return state.copyWith(exchanges: action.exchanges);
}

CcxtState _updateCurrentMarket(CcxtState state, UpdateCurrentMarketAction action) {
  return state.copyWith(currentMarket: action.market);
}

CcxtState _updateMarkets(CcxtState state, UpdateMarketsAction action) {
  return state.copyWith(markets: action.markets);
}
