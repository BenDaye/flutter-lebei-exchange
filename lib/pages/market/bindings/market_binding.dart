import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ohlcv_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/trade_controller.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
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
  }
}
