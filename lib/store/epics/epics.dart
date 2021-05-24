import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:flutter_lebei_exchange/store/epics/ccxt/fetch_exchanges.dart';
import 'package:redux_epics/redux_epics.dart';

final epics = combineEpics<AppState>([
  fetchExchangesEpic,
]);
