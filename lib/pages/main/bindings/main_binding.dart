import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/pages/main/controllers/main_controller.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/markets_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());

    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<TickerController>(() => TickerController());
    Get.lazyPut<SymbolController>(() => SymbolController());

    Get.lazyPut<MainViewController>(() => MainViewController());
    Get.lazyPut<HomeViewController>(() => HomeViewController());
    Get.lazyPut<MarketsViewController>(() => MarketsViewController());
  }
}
