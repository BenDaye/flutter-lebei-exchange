import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/currency_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/main/controllers/main_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());

    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<SymbolController>(() => SymbolController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<CurrencyController>(() => CurrencyController());
    Get.lazyPut<TickerController>(() => TickerController());

    Get.lazyPut<MainViewController>(() => MainViewController());
    Get.lazyPut<HomeViewController>(() => HomeViewController());
    Get.lazyPut<MarketsViewController>(() => MarketsViewController());
  }
}
