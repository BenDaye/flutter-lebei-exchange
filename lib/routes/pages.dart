import 'package:flutter_lebei_exchange/pages/exchange/bindings/exchange_binding.dart';
import 'package:flutter_lebei_exchange/pages/exchange/views/exchanges_view.dart';
import 'package:flutter_lebei_exchange/pages/main/bindings/main_binding.dart';
import 'package:flutter_lebei_exchange/pages/main/views/main_view.dart';
import 'package:flutter_lebei_exchange/pages/market/bindings/market_binding.dart';
import 'package:flutter_lebei_exchange/pages/market/views/market_view.dart';
import 'package:flutter_lebei_exchange/pages/setting/bindings/settings_binding.dart';
import 'package:flutter_lebei_exchange/pages/setting/views/general_view.dart';
import 'package:flutter_lebei_exchange/pages/setting/views/language_view.dart';
import 'package:flutter_lebei_exchange/pages/setting/views/settings_view.dart';
import 'package:get/route_manager.dart';

part 'routes.dart';

class Pages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.EXCHANGES,
      page: () => ExchangesView(),
      binding: ExchangeBinding(),
    ),
  ]
    ..addAll(marketRoutes)
    ..addAll(settingRoutes);

  static final marketRoutes = [
    GetPage(
      name: Routes.MARKET,
      page: () => MarketView(),
      binding: MarketBinding(),
    ),
  ];

  static final settingRoutes = [
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS_GENERAL,
      page: () => GeneralView(),
      // binding: MarketBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS_GENERAL_LANGUAGE,
      page: () => LanguageView(),
      // binding: MarketBinding(),
    ),
  ];
}
