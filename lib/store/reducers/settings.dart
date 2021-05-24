import 'package:flutter_lebei_exchange/store/actions/change_theme_mode.dart';
import 'package:flutter_lebei_exchange/store/settings.dart';
import 'package:redux/redux.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, ChangeThemeModeAction>(_changeThemeMode),
]);

SettingsState _changeThemeMode(SettingsState state, ChangeThemeModeAction action) {
  return state.copyWith(themeMode: action.themeMode);
}
