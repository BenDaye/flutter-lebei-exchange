import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Precision;

import '../../../../models/ccxt/market.dart';
import '../../../../models/ccxt/ticker.dart';
import '../../../../utils/handlers/timer.dart';
import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/controllers/ticker_controller.dart';
import '../../../commons/settings/controller/settings_controller.dart';

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
  late Worker watchSymbolWorker;

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

    watchSymbolWorker = ever(symbolController.currentSymbol, watchSymbol);

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    watchSymbol(symbolController.currentSymbol.value);
    Future<void>.delayed(
      Duration(seconds: settingsController.autoRefresh.value.toInt()),
      () => TimerHandler.watchAutoRefresh(timer)(settingsController.autoRefresh.value),
    );
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    tabController.dispose();

    watchSymbolWorker.dispose();
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
