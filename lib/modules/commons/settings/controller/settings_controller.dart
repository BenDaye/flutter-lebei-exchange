import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../api/juhe.dart';
import '../../../../assets/translations/main.dart';
import '../../../../models/juhe/exchange.dart';
import '../../../../utils/http/handler/types.dart';
import '../../ccxt/controllers/exchange_controller.dart';

enum AdvanceDeclineColorMode {
  advanceGreen,
  advanceRed,
}

class SettingsController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  final Rx<Locale> locale = const Locale('en', 'US').obs;
  final RxString currency = 'USD'.obs;
  final RxDouble currencyRate = 1.0.obs;
  final Rx<AdvanceDeclineColorMode> advanceDeclineColorMode = AdvanceDeclineColorMode.advanceGreen.obs;
  final RxList<Color> advanceDeclineColors = <Color>[Colors.green, Colors.grey, Colors.red].obs;

  final RxBool wakelock = false.obs;
  final RxDouble autoRefresh = 0.0.obs;

  final Rx<ConnectivityResult> connectivityResult = ConnectivityResult.none.obs;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult event) => connectivityResult.value = event);

    ever(themeMode, watchThemeMode);
    ever(locale, watchLocale);
    ever(currency, watchCurrency);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    connectivityResult.value = await Connectivity().checkConnectivity();

    themeMode.value = SpUtil.getString('Settings.themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light;

    _initLocale();

    currency.value = SpUtil.getString('Settings.currency', defValue: 'USD') ?? 'USD';

    advanceDeclineColorMode.value = AdvanceDeclineColorMode.values[SpUtil.getInt('Settings.color') ?? 0];
    if (advanceDeclineColorMode.value == AdvanceDeclineColorMode.advanceRed) {
      advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    }

    wakelock.value = await Wakelock.enabled;
    autoRefresh.value = SpUtil.getDouble('Settings.autoRefresh') ?? 0.0;
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }

  void _initLocale() {
    final String? _localeString = SpUtil.getString('Settings.locale', defValue: 'en-US');
    Locale _locale;
    switch (_localeString) {
      case 'zh-CN':
        {
          _locale = const Locale('zh', 'CN');
        }
        break;
      default:
        {
          _locale = const Locale('en', 'US');
        }
        break;
    }

    if (TranslationService.supportLanguages.contains(_locale)) {
      locale.value = _locale;
    } else {
      SpUtil.remove('Settings.locale');
      locale.value = TranslationService.fallbackLocale;
    }
  }

  void watchThemeMode(ThemeMode _themeMode) {
    Get.changeThemeMode(_themeMode);
    SpUtil.putString('Settings.themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void watchLocale(Locale _locale) {
    Get.updateLocale(_locale);
    SpUtil.putString('Settings.locale', _locale.toLanguageTag());
    switch (_locale.toLanguageTag()) {
      case 'zh-CN':
        {
          onChangeCurrency('CNY');
        }
        break;
      default:
        {
          onChangeCurrency('USD');
        }
        break;
    }
  }

  void watchCurrency(String _code) {
    if (_code == 'USD') {
      currencyRate.value = 1.0;
    } else {
      getCurrencyRateAndUpdate();
    }
  }

  // ignore: use_setters_to_change_properties
  void onSwitchThemeMode(ThemeMode _themeMode) {
    themeMode.value = _themeMode;
  }

  void onChangeLocale(Locale _locale) {
    locale.value = _locale;
    if (Get.currentRoute == '/settings/general/language') {
      Get.back();
    }
  }

  void onSwitchAdvanceDeclineColorMode(AdvanceDeclineColorMode _mode) {
    advanceDeclineColorMode.value = _mode;
    advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    SpUtil.putInt('Settings.color', _mode.index);
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> onSwitchWakelock(bool enable) async {
    await Wakelock.toggle(enable: enable);
    wakelock.value = await Wakelock.enabled;
  }

  void onChangeAutoRefresh(double second) {
    autoRefresh.value = second;
    SpUtil.putDouble('Settings.autoRefresh', second);
  }

  void onChangeCurrency(String _code) {
    currency.value = _code;
    SpUtil.putString('Settings.currency', _code);
    if (Get.currentRoute == '/settings/general/currency') {
      Get.back();
    }
  }

  Future<void> getCurrencyRateAndUpdate({bool reload = false}) async {
    if (currency.value.isEmpty) return;

    if (!reload) {
      final double? _currencyRateLocal = await getCurrencyRateLocal();
      if (_currencyRateLocal is double && !_currencyRateLocal.isEqual(0)) {
        currencyRate.value = _currencyRateLocal;
        return;
      }
    }

    final double? _currencyRate = await getCurrencyRate();
    if (_currencyRate is double) {
      currencyRate.value = _currencyRate;
      SpUtil.putDouble('Settings.currency.${currency.value}', _currencyRate);
    }
  }

  Future<double?> getCurrencyRateLocal() async {
    if (currency.value == 'USD') return 1.0;
    return SpUtil.getDouble('Settings.currency.${currency.value}');
  }

  Future<double?> getCurrencyRate() async {
    if (currency.value == 'USD') return 1.0;

    final HttpResult<List<dynamic>> result = await ApiJuhe.exchangeCurrency('USD', currency.value);
    if (!result.success) return null;

    final List<Rate> _rates =
        List<Rate>.from(result.data!.map((dynamic e) => Rate.fromJson(e as Map<String, dynamic>)));
    return NumUtil.getDoubleByValueStr(_rates.first.exchange);
  }

  Future<void> resetAppDialog() async {
    final bool? isConfirm = await Get.dialog<bool>(
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.error),
                  title: Text('GeneralPage.Reset'.tr),
                  subtitle: Text('GeneralPage.Reset.Desc'.tr),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Get.back<bool>(result: true),
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text('Common.Action.Confirm'.tr),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Get.back<bool>(result: false),
                        style: TextButton.styleFrom(
                          primary: Get.context?.textTheme.caption?.color,
                        ),
                        child: Text('Common.Action.Cancel'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (isConfirm == true) {
      resetApp();
    }
  }

  void resetSettings() {
    themeMode.value = ThemeMode.light;
    locale.value = const Locale('en', 'US');
    currency.value = 'USD';
    advanceDeclineColorMode.value = AdvanceDeclineColorMode.advanceGreen;

    wakelock.value = false;
    autoRefresh.value = 0.0;
  }

  Future<void> resetApp() async {
    await SpUtil.clear();
    resetSettings();
    final ExchangeController exchangeController = Get.find<ExchangeController>();
    exchangeController.currentExchangeId.value = '';
  }
}
