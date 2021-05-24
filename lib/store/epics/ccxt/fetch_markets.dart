import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/fetch_markets.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_markets.dart';
import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<dynamic> fetchMarketsEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  // Wrap our actions Stream as an Observable. This will enhance the stream with
  // a bit of extra functionality.
  return actions
      // Use `whereType` to narrow down to PerformSearchAction
      .whereType<FetchMarketsAction>()
      .asyncMap(
        (action) => ApiCcxt.markets(store.state.ccxtState.currentExchangeId!)
            .then(
              (result) => UpdateMarketsAction({}),
            )
            .catchError(
              (e) => UpdateMarketsAction({}),
            ),
      );
}
