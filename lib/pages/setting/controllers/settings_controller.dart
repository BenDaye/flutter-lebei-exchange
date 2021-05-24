import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AdvanceDeclineColorMode {
  AdvanceGreen,
  AdvanceRed,
}

class SettingsController extends GetxController {
  final themeMode = ThemeMode.dark.obs;
  final locale = Locale('cn', 'zh').obs;
  final advanceDeclineColorMode = AdvanceDeclineColorMode.AdvanceGreen.obs;
  final advanceDeclineColors = <Color>[Colors.green, Colors.grey, Colors.red].obs;

  @override
  void onInit() {
    super.onInit();
    ever(themeMode, (ThemeMode _themeMode) {
      Get.changeThemeMode(_themeMode);
      SpUtil.putString('themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
    });
    ever(locale, (Locale _locale) {
      Get.updateLocale(_locale);
    });
  }

  @override
  void onReady() {
    super.onReady();
    themeMode.value = SpUtil.getString('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  void onSwitchThemeMode(ThemeMode _themeMode) {
    themeMode.value = _themeMode;
  }

  void onChangeLocale(Locale _locale) {
    locale.value = _locale;
  }

  void onSwitchAdvanceDeclineColorMode(AdvanceDeclineColorMode _mode) {
    advanceDeclineColorMode.value = _mode;
    advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
  }
}
