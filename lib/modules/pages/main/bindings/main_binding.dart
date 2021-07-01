import 'package:get/get.dart';

import '../../../commons/ccxt/controllers/currency_controller.dart';
import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/controllers/ohlcv_controller.dart';
import '../../../commons/ccxt/controllers/orderbook_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/controllers/ticker_controller.dart';
import '../../../commons/ccxt/controllers/trade_controller.dart';
import '../../../commons/settings/controller/settings_controller.dart';
import '../../market/controllers/chart_controller.dart';
import '../../market/controllers/orderbook_list_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController(), permanent: true);

    Get.put<ExchangeController>(ExchangeController(), permanent: true);
    Get.put<SymbolController>(SymbolController(), permanent: true);
    Get.put<MarketController>(MarketController(), permanent: true);
    Get.put<CurrencyController>(CurrencyController(), permanent: true);
    Get.put<TickerController>(TickerController(), permanent: true);
    Get.put<OhlcvController>(OhlcvController(), permanent: true);
    Get.put<OrderBookController>(OrderBookController(), permanent: true);
    Get.put<TradeController>(TradeController(), permanent: true);

    Get.put<OrderBookListController>(OrderBookListController(), permanent: true, tag: 'TradePageOrderBook');
    Get.put<ChartController>(ChartController(), permanent: true, tag: 'TradePageOhlcv');

    Get.put<MainViewController>(MainViewController(), permanent: true);
  }
}
