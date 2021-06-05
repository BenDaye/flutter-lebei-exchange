import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ohlcv_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/trade_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/models/ccxt/orderbook.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/models/ccxt/trade.dart';
import 'package:get/get.dart' hide Precision;
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/flutter_k_chart.dart';

class MarketViewController extends GetxController with SingleGetTickerProviderMixin {
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  final TickerController tickerController = Get.find<TickerController>();
  final OhlcvController ohlcvController = Get.find<OhlcvController>();
  final OrderBookController orderBookController = Get.find<OrderBookController>();
  final TradeController tradeController = Get.find<TradeController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // final symbol = ''.obs;

  final market = Market.empty().obs;
  final ticker = Ticker.empty().obs;
  final ohlcv = <List<num>>[].obs;

  final orderBook = OrderBook.empty().obs;
  final depth = OrderBook.empty().obs;
  final trades = <Trade>[].obs;

  final kline = <KLineEntity>[].obs;
  final depthBids = <DepthEntity>[].obs;
  final depthAsks = <DepthEntity>[].obs;
  final showKlineSettings = false.obs;
  final mainSatte = MainState.MA.obs;
  final secondaryState = SecondaryState.NONE.obs;

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
  final innerScrollPositionKey = Key('MarketPage.TabBar.Order').obs;

  final klineTabs = [
    'MarketPage.Period.1m',
    'MarketPage.Period.1h',
    'MarketPage.Period.1d',
    'MarketPage.Period.1M',
    // 'MarketPage.Period.1y',
    'MarketPage.Period.depth',
  ]
      .map<Tab>(
        (t) => Tab(
          text: t.tr,
          key: Key(t),
        ),
      )
      .toList()
      .obs;
  late TabController klineTabController;
  final period = '1m'.obs;

  final timer = new TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();

    timerWorker = debounce(settingsController.autoRefresh, watchAutoRefresh, time: Duration(milliseconds: 800));
    timer.setOnTimerTickCallback(handleTimer);

    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(tabControllerListener);
    klineTabController = TabController(
      length: klineTabs.length,
      vsync: this,
    );
    klineTabController.addListener(klineTabControllerListener);
  }

  @override
  void onReady() {
    super.onReady();

    watchAutoRefresh(settingsController.autoRefresh.value);

    ever(symbolController.currentSymbol, watchSymbol);
    ever(ohlcv, watchOhlcv);
    ever(depth, watchDepth);

    debounce(period, watchPeriod, time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    klineTabController.removeListener(klineTabControllerListener);
    klineTabController.dispose();

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
    this.getMarket(_symbol, update: true);
    this.getTicker(_symbol, update: true);
    this.getOhlcv(_symbol, update: true);
    if (period.value == 'depth') {
      this.getDepth(_symbol, update: true);
    } else {
      this.getOrderBook(_symbol, update: true);
    }
    this.getTrades(_symbol, update: true);
  }

  void watchOhlcv(List<List<num>> _ohlcv) {
    final list = List<KLineEntity>.from(
      _ohlcv
          .map(
            (item) => KLineEntity.fromCustom(
              time: item[0] as int,
              open: (item[1]).toDouble(),
              high: (item[2]).toDouble(),
              low: (item[3]).toDouble(),
              close: (item[4]).toDouble(),
              vol: (item[5]).toDouble(),
            ),
          )
          .toList(),
    );
    DataUtil.calculate(list);
    kline.value = list;
    this.update(['ohlcv']);
  }

  void watchDepth(OrderBook _depth) {
    final _bids = List<DepthEntity>.from(
      _depth.bids.map(
        (item) => DepthEntity(
          item[0].toDouble(),
          item[1].toDouble(),
        ),
      ),
    ).toList();
    final _asks = List<DepthEntity>.from(
      _depth.asks.map(
        (item) => DepthEntity(
          item[0].toDouble(),
          item[1].toDouble(),
        ),
      ),
    ).toList();

    depthBids.value = _bids;
    depthAsks.value = _asks;

    this.update(['ohlcv']);
  }

  void watchPeriod(String _period) {
    if (_period != 'depth') {
      this.getOhlcv(symbolController.currentSymbol.value, period: _period, update: true);
    } else {
      this.getDepth(symbolController.currentSymbol.value, update: true);
    }
  }

  void tabControllerListener() {
    innerScrollPositionKey.value = tabs[tabController.index].key!;
  }

  void klineTabControllerListener() {
    period.value = new RegExp(r"(?<=').*?(?=')")
        .stringMatch(
          klineTabs[klineTabController.index].key!.toString(),
        )!
        .split('.')
        .last;
  }

  Future<Market?> getMarket(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return null;
    final data = await marketController.getMarket(s);
    if (data is Market) {
      if (update == true) market.value = data;
      return data;
    }
    return null;
  }

  Future<Ticker?> getTicker(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return null;
    final data = await tickerController.getTicker(s);
    if (data is Ticker) {
      if (update == true) ticker.value = data;
      return data;
    }
    return null;
  }

  Future<List<List<num>>> getOhlcv(String? _symbol, {bool? update, String period = '1m'}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return [];
    final data = await ohlcvController.getOhlcv(s, period: period);
    if (data is List<List<num>>) {
      if (update == true) ohlcv.value = data;
      return data;
    }
    return [];
  }

  Future<OrderBook?> getOrderBook(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return null;
    final data = await orderBookController.getOrderBook(s);
    if (data is OrderBook) {
      if (update == true) orderBook.value = data;
      return data;
    }
    return null;
  }

  Future<OrderBook?> getDepth(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return null;
    final data = await orderBookController.getDepth(s);
    if (data is OrderBook) {
      if (update == true) depth.value = data;
      return data;
    }
    return null;
  }

  Future<List<Trade>> getTrades(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbolController.currentSymbol.value;
    if (s.isEmpty) return [];
    final data = await tradeController.getTrades(s);
    if (data is List<Trade>) {
      if (update == true) trades.value = data;
      return data;
    }
    return [];
  }

  void toggleShowKlineSetting() {
    showKlineSettings.toggle();
  }

  Future handleTimer(int tick) async {
    print('MarketViewController AutoRefresh ==> $tick, Timer: ${timer.mInterval}');
    if (symbolController.currentSymbol.value.isEmpty) return;

    this.getMarket(symbolController.currentSymbol.value, update: true);
    this.getTicker(symbolController.currentSymbol.value, update: true);
    if (period.value == 'depth') {
      this.getDepth(symbolController.currentSymbol.value, update: true);
    } else {
      this.getOhlcv(symbolController.currentSymbol.value, update: true, period: period.value);
    }
    this.getOrderBook(symbolController.currentSymbol.value, update: true);
    this.getTrades(symbolController.currentSymbol.value, update: true);
  }
}
