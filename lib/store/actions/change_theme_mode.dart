import 'package:flutter/material.dart';

class ChangeThemeModeAction {
  final ThemeMode themeMode;
  ChangeThemeModeAction(this.themeMode);

  @override
  String toString() {
    return 'ChangeThemeModeAction(themeMode: $themeMode)';
  }
}
