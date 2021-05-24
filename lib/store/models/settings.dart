import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/store/actions/change_theme_mode.dart';
import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:redux/redux.dart';

class ThemeModeModel {
  final ThemeMode themeMode;
  Function(ThemeMode) onChangeThemeMode;

  ThemeModeModel({
    required this.themeMode,
    required this.onChangeThemeMode,
  });

  static ThemeModeModel fromStore(Store<AppState> store) => ThemeModeModel(
        themeMode: store.state.settingsState.themeMode,
        onChangeThemeMode: (ThemeMode themeMode) => store.dispatch(
          ChangeThemeModeAction(themeMode),
        ),
      );
}
