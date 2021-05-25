import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AdvanceDeclineColorMode {
  AdvanceGreen,
  AdvanceRed,
}

class SettingsController extends GetxController {
  final themeMode = ThemeMode.dark.obs;
  final locale = Locale('zh', 'CN').obs;
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
      SpUtil.putString('locale', _locale.toLanguageTag());
    });
  }

  @override
  void onReady() {
    super.onReady();
    themeMode.value = SpUtil.getString('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    // TODO: 本地存储语言
    locale.value = SpUtil.getString('locale') == 'zh-CN' ? Locale('zh', 'CN') : Locale('en', 'US');
    advanceDeclineColorMode.value = AdvanceDeclineColorMode.values[SpUtil.getInt('color') ?? 0];
    if (advanceDeclineColorMode.value == AdvanceDeclineColorMode.AdvanceRed) {
      advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    }
  }

  void onSwitchThemeMode(ThemeMode _themeMode) {
    themeMode.value = _themeMode;
  }

  void onChangeLocale(Locale _locale) {
    locale.value = _locale;
    Get.back();
  }

  void onSwitchAdvanceDeclineColorMode(AdvanceDeclineColorMode _mode) {
    advanceDeclineColorMode.value = _mode;
    advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    SpUtil.putInt('color', _mode.index);
  }
}
