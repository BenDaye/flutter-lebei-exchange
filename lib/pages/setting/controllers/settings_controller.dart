import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

enum AdvanceDeclineColorMode {
  AdvanceGreen,
  AdvanceRed,
}

class SettingsController extends GetxController {
  final themeMode = ThemeMode.dark.obs;
  final locale = Locale('zh', 'CN').obs;
  final advanceDeclineColorMode = AdvanceDeclineColorMode.AdvanceGreen.obs;
  final advanceDeclineColors = <Color>[Colors.green, Colors.grey, Colors.red].obs;

  final wakelock = false.obs;
  final autoRefresh = 60.0.obs;

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
  void onReady() async {
    super.onReady();
    themeMode.value = SpUtil.getString('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    // TODO: 本地存储语言
    locale.value = SpUtil.getString('locale') == 'zh-CN' ? Locale('zh', 'CN') : Locale('en', 'US');
    advanceDeclineColorMode.value = AdvanceDeclineColorMode.values[SpUtil.getInt('color') ?? 0];
    if (advanceDeclineColorMode.value == AdvanceDeclineColorMode.AdvanceRed) {
      advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    }

    wakelock.value = await Wakelock.enabled;
    autoRefresh.value = SpUtil.getDouble('autoRefresh') ?? 60.0;
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

  void onSwitchWakelock(bool enable) async {
    await Wakelock.toggle(enable: enable);
    wakelock.value = await Wakelock.enabled;
  }

  void onChangeAutoRefresh(double second) {
    autoRefresh.value = second;
    SpUtil.putDouble('autoRefresh', second);
  }
}
