// ignore_for_file: constant_identifier_names,always_specify_types

import 'package:flutter_lebei_exchange/modules/pages/balance/bindings/balances_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/exchange/bindings/exchanges_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/exchange/views/exchanges_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/bindings/home_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/main/bindings/main_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/main/views/main_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/bindings/market_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/bindings/markets_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/market_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/search_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/bindings/settings_binding.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/views/currency_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/views/general_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/views/language_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/views/settings_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/trade/bindings/trades_binding.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

part 'routes.dart';

class Pages {
  static const String INITIAL = Routes.INITIAL;

  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: INITIAL,
      page: () => MainView(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        MarketsBinding(),
        TradesBinding(),
        BalancesBinding(),
      ],
    ),
    GetPage(
      name: Routes.EXCHANGES,
      page: () => ExchangesView(),
      binding: ExchangesBinding(),
    ),
    ...marketRoutes,
    ...settingRoutes,
  ];

  static final List<GetPage> marketRoutes = <GetPage>[
    GetPage(
      name: Routes.MARKET,
      page: () => MarketView(),
      binding: MarketBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_SYMBOL,
      page: () => SearchMarketView(),
    ),
  ];

  static final settingRoutes = [
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
      children: [
        GetPage(
          name: Routes.SETTINGS_GENERAL,
          page: () => GeneralView(),
          children: [
            GetPage(
              name: Routes.SETTINGS_GENERAL_LANGUAGE,
              page: () => LanguageView(),
            ),
            GetPage(
              name: Routes.SETTINGS_GENERAL_CURRENCY,
              page: () => CurrencyView(),
            ),
          ],
        ),
      ],
    ),
  ];
}
