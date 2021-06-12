import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
import 'package:get/get.dart' hide Precision;
// ignore: import_of_legacy_library_into_null_safe

class MarketViewController extends GetxController with SingleGetTickerProviderMixin {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  final TickerController tickerController = Get.find<TickerController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<Market> market = Market.empty().obs;
  final Rx<Ticker> ticker = Ticker.empty().obs;

  final RxList<Tab> tabs = <String>[
    'MarketPage.TabBar.Order',
    'MarketPage.TabBar.Trade',
    'MarketPage.TabBar.Intro',
    'MarketPage.TabBar.Exchanges',
  ]
      .map<Tab>(
        (String t) => Tab(
          text: t.tr,
          key: Key(t),
        ),
      )
      .toList()
      .obs;
  late TabController tabController;

  final TimerUtil timer = TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();

    timerWorker = debounce(
      settingsController.autoRefresh,
      TimerHandler.watchAutoRefresh(timer),
      time: const Duration(milliseconds: 800),
    );
    timer.setOnTimerTickCallback(
      TimerHandler.common(
        name: 'MarketViewController',
        action: getDataAndUpdate,
      ),
    );

    ever(symbolController.currentSymbol, watchSymbol);

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    TimerHandler.watchAutoRefresh(timer)(settingsController.autoRefresh.value);
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    tabController.dispose();

    super.onClose();
  }

  void watchSymbol(String _symbol) {
    if (_symbol.isEmpty) return;
    getDataAndUpdate();
  }

  Future<void> getDataAndUpdate() async {
    getMarketAndUpdate();
    getTickerAndUpdate();
  }

  Future<void> getMarketAndUpdate({String? symbol, String? exchangeId}) async {
    final Market? result = await marketController.getMarket(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    market.value = result;
  }

  Future<void> getTickerAndUpdate({String? symbol, String? exchangeId}) async {
    final Ticker? result = await tickerController.getTicker(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    ticker.value = result;
  }
}
