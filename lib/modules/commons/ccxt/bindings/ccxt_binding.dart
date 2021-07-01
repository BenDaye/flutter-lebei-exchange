import 'package:get/get.dart';

import '../controllers/exchange_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/symbol_controller.dart';
import '../controllers/ticker_controller.dart';

class CcxtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<TickerController>(() => TickerController());
    Get.lazyPut<SymbolController>(() => SymbolController());
  }
}
