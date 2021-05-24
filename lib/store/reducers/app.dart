import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:flutter_lebei_exchange/store/reducers/ccxt.dart';
import 'package:flutter_lebei_exchange/store/reducers/settings.dart';

AppState appReducer(AppState appState, dynamic action) => AppState(
      settingsState: settingsReducer(appState.settingsState, action),
      ccxtState: ccxtReducers(appState.ccxtState, action),
    );
