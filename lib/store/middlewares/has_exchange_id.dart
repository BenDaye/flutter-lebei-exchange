import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/fetch_markets.dart';
import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

void checkExchangeIdMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is FetchMarketsAction) {
    bool hasExchangeId = TextUtil.isEmpty(store.state.ccxtState.currentExchangeId);
    if (!hasExchangeId) {
      Logger().e('checkExchangeIdMiddleware: exchangeId is required');
      return;
    }
  }

  next(action);
}
