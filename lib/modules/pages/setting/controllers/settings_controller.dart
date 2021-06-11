import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/api/juhe.dart';
import 'package:flutter_lebei_exchange/assets/translations/main.dart';
import 'package:flutter_lebei_exchange/models/juhe/exchange.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

enum AdvanceDeclineColorMode {
  AdvanceGreen,
  AdvanceRed,
}

class SettingsController extends GetxController {
  final themeMode = ThemeMode.dark.obs;
  final locale = Locale('en', 'US').obs;
  final currency = 'USD'.obs;
  final currencyRate = 1.0.obs;
  final advanceDeclineColorMode = AdvanceDeclineColorMode.AdvanceGreen.obs;
  final advanceDeclineColors = <Color>[Colors.green, Colors.grey, Colors.red].obs;

  final wakelock = false.obs;
  final autoRefresh = 60.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(themeMode, watchThemeMode);
    ever(locale, watchLocale);
    ever(currency, watchCurrency);
  }

  @override
  void onReady() async {
    super.onReady();

    themeMode.value =
        SpUtil.getString('Settings.themeMode', defValue: 'dark') == 'dark' ? ThemeMode.dark : ThemeMode.light;

    _initLocale();

    currency.value = SpUtil.getString('Settings.currency', defValue: 'USD') ?? 'USD';

    advanceDeclineColorMode.value = AdvanceDeclineColorMode.values[SpUtil.getInt('Settings.color', defValue: 0) ?? 0];
    if (advanceDeclineColorMode.value == AdvanceDeclineColorMode.AdvanceRed) {
      advanceDeclineColors.value = advanceDeclineColors.reversed.toList();
    }

    wakelock.value = await Wakelock.enabled;
    autoRefresh.value = SpUtil.getDouble('Settings.autoRefresh', defValue: 60.0) ?? 60.0;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initLocale() {
    String? _localeString = SpUtil.getString('Settings.locale', defValue: 'en-US');
    Locale _locale;
    switch (_localeString) {
      case 'zh-CN':
        {
          _locale = Locale('zh', 'CN');
        }
        break;
      default:
        {
          _locale = Locale('en', 'US');
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

  void onSwitchWakelock(bool enable) async {
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

  Future getCurrencyRateAndUpdate({bool reload = false}) async {
    if (currency.value.isEmpty) return;

    if (!reload) {
      double? _currencyRateLocal = await getCurrencyRateLocal();
      if (_currencyRateLocal is double && !_currencyRateLocal.isEqual(0)) {
        currencyRate.value = _currencyRateLocal;
        return;
      }
    }

    double? _currencyRate = await getCurrencyRate();
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

    final result = await ApiJuhe.exchangeCurrency('USD', currency.value);
    if (!result.success) return null;

    List<Rate> _rates = List<Rate>.from(result.data!.map((e) => Rate.fromJson(e)));
    return NumUtil.getDoubleByValueStr(_rates.first.exchange);
  }

  Future resetAppDialog() async {
    bool? isConfirm = await Get.dialog<bool>(
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.error),
                  title: Text('GeneralPage.Reset'.tr),
                  subtitle: Text('GeneralPage.Reset.Desc'.tr),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back<bool>(result: true),
                        child: Text('Common.Action.Confirm'.tr),
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                      SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Get.back<bool>(result: false),
                        child: Text('Common.Action.Cancel'.tr),
                        style: TextButton.styleFrom(
                          primary: Get.context?.textTheme.caption?.color,
                        ),
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

  Future resetApp() async {
    await SpUtil.clear();
    Get.reloadAll(force: true);
    Get.forceAppUpdate();
  }
}
