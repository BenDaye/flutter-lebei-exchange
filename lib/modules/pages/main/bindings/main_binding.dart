import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/currency_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController(), permanent: true);

    Get.put<ExchangeController>(ExchangeController(), permanent: true);
    Get.put<SymbolController>(SymbolController(), permanent: true);
    Get.put<MarketController>(MarketController(), permanent: true);
    Get.put<CurrencyController>(CurrencyController(), permanent: true);
    Get.put<TickerController>(TickerController(), permanent: true);

    Get.put<MainViewController>(MainViewController(), permanent: true);
  }
}
