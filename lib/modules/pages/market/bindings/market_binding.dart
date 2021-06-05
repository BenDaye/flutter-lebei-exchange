import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/ohlcv_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/trade_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/exchange_list_view_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_view_controller.dart';
import 'package:get/get.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketViewController>(() => MarketViewController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<TickerController>(() => TickerController());
    Get.lazyPut<OhlcvController>(() => OhlcvController());
    Get.lazyPut<OrderBookController>(() => OrderBookController());
    Get.lazyPut<TradeController>(() => TradeController());
    Get.lazyPut<ExchangeListViewController>(() => ExchangeListViewController());
  }
}
