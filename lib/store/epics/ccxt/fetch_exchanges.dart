import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/fetch_exchanges.dart';
import 'package:flutter_lebei_exchange/store/actions/ccxt/update_exchanges.dart';
import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<dynamic> fetchExchangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  // Wrap our actions Stream as an Observable. This will enhance the stream with
  // a bit of extra functionality.
  return actions
      // Use `whereType` to narrow down to PerformSearchAction
      .whereType<FetchExchangesAction>()
      .asyncMap(
        (action) => ApiCcxt.exchanges()
            .then(
              (result) => UpdateExchangesAction(List<String>.from(result.data!)),
            )
            .catchError(
              (e) => UpdateExchangesAction([]),
            ),
      );
}
