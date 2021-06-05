import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/ticker_controller.dart';
import 'package:get/get.dart';

class CcxtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<TickerController>(() => TickerController());
    Get.lazyPut<SymbolController>(() => SymbolController());
  }
}
