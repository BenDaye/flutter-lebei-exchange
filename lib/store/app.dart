import 'package:flutter_lebei_exchange/store/ccxt.dart';
import 'package:flutter_lebei_exchange/store/settings.dart';

enum Actions { Setting }

class AppState {
  final SettingsState settingsState;
  final CcxtState ccxtState;

  AppState({
    required this.settingsState,
    required this.ccxtState,
  });

  AppState copyWith({
    SettingsState? settingsState,
    CcxtState? ccxtState,
  }) =>
      AppState(
        settingsState: settingsState ?? this.settingsState,
        ccxtState: ccxtState ?? this.ccxtState,
      );

  static AppState initialState() => AppState(
        settingsState: SettingsState.initialState(),
        ccxtState: CcxtState.initialState(),
      );
}
