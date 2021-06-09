import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/funtions/timer.dart';
import 'package:get/get.dart' hide Precision;
// ignore: import_of_legacy_library_into_null_safe

class MarketViewController extends GetxController with SingleGetTickerProviderMixin {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  final TickerController tickerController = Get.find<TickerController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final market = Market.empty().obs;
  final ticker = Ticker.empty().obs;

  final tabs = [
    'MarketPage.TabBar.Order',
    'MarketPage.TabBar.Trade',
    'MarketPage.TabBar.Intro',
    'MarketPage.TabBar.Exchanges',
  ]
      .map<Tab>(
        (t) => Tab(
          text: t.tr,
          key: Key(t),
        ),
      )
      .toList()
      .obs;
  late TabController tabController;

  final timer = new TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();

    timerWorker = debounce(settingsController.autoRefresh, watchAutoRefresh, time: Duration(milliseconds: 800));
    timer.setOnTimerTickCallback(TimerHandler.common(name: 'MarketViewController', action: getDataAndUpdate));

    ever(symbolController.currentSymbol, watchSymbol);

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    watchAutoRefresh(settingsController.autoRefresh.value);
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    tabController.dispose();

    super.onClose();
  }

  void watchAutoRefresh(double _m) {
    if (timer.isActive()) timer.cancel();
    if (!_m.isEqual(0)) {
      timer.setInterval(_m.toInt() * 1000);
      timer.startTimer();
    }
  }

  void watchSymbol(String _symbol) async {
    if (_symbol.isEmpty) return;
    getDataAndUpdate();
  }

  Future getDataAndUpdate() async {
    getMarketAndUpdate();
    getTickerAndUpdate();
  }

  Future getMarketAndUpdate({String? symbol, String? exchangeId}) async {
    final result = await marketController.getMarket(symbol: symbol, exchangeId: exchangeId);
    if (result is Market) {
      market.value = result;
    }
  }

  Future getTickerAndUpdate({String? symbol, String? exchangeId}) async {
    final result = await tickerController.getTicker(symbol: symbol, exchangeId: exchangeId);
    if (result is Ticker) {
      ticker.value = result;
    }
  }

  Future handleTimer(int tick) async {
    print('MarketViewController AutoRefresh ==> $tick, Timer: ${timer.mInterval}');
    if (symbolController.currentSymbol.value.isEmpty) return;

    getDataAndUpdate();
  }
}
