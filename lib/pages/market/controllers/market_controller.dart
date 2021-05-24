import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ohlcv_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/trade_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/orderbook.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/trade.dart';
import 'package:get/get.dart' hide Precision;
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/flutter_k_chart.dart';

class MarketViewController extends GetxController with SingleGetTickerProviderMixin {
  final MarketController marketController = Get.find<MarketController>();
  final TickerController tickerController = Get.find<TickerController>();
  final OhlcvController ohlcvController = Get.find<OhlcvController>();
  final OrderBookController orderBookController = Get.find<OrderBookController>();
  final TradeController tradeController = Get.find<TradeController>();

  final symbol = ''.obs;

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

  final tabs = ['委托挂单', '成交', '简介']
      .map<Tab>((t) => Tab(
            text: t,
            key: Key(t),
          ))
      .toList()
      .obs;
  late TabController tabController;
  final innerScrollPositionKey = Key('委托挂单').obs;

  final klineTabs = ['1m', '1h', '1d', '1M', '1y', 'deep']
      .map<Tab>((t) => Tab(
            text: t,
            key: Key(t),
          ))
      .toList()
      .obs;
  late TabController klineTabController;
  final period = '1m'.obs;

  @override
  void onInit() {
    super.onInit();
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
    ever(symbol, watchSymbol);
    symbol.value = Get.parameters['symbol']!;
    ever(ohlcv, watchOhlcv);
    ever(depth, watchDepth);
    // !!!: 防止过快切换
    debounce(period, watchPeriod, time: Duration(seconds: 1));
  }

  @override
  void onClose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    klineTabController.removeListener(klineTabControllerListener);
    klineTabController.dispose();
    super.onClose();
  }

  void watchSymbol(String _symbol) async {
    if (_symbol.isEmpty) return;
    this.getMarket(_symbol, update: true);
    this.getTicker(_symbol, update: true);
    this.getOhlcv(_symbol, update: true);
    this.getOrderBook(_symbol, update: true);
    // this.getDepth(_symbol, update: true);
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
    final _bids =
        List<DepthEntity>.from(_depth.bids.map((item) => DepthEntity(item[0].toDouble(), item[1].toDouble()))).toList();
    // _bids.sort((a, b) => b.price.compareTo(a.price));
    final _asks =
        List<DepthEntity>.from(_depth.asks.map((item) => DepthEntity(item[0].toDouble(), item[1].toDouble()))).toList();
    // _asks.sort((a, b) => b.price.compareTo(a.price));

    depthBids.value = _bids;
    depthAsks.value = _asks;

    this.update(['ohlcv']);
  }

  void watchPeriod(String _period) {
    if (_period != 'deep') {
      this.getOhlcv(symbol.value, period: _period, update: true);
    } else {
      this.getDepth(symbol.value, update: true);
    }
  }

  void tabControllerListener() {
    innerScrollPositionKey.value = tabs[tabController.index].key!;
  }

  void klineTabControllerListener() {
    period.value = klineTabs[klineTabController.index].text!;
  }

  Future<Market?> getMarket(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return null;
    final data = await marketController.getMarket(s);
    if (data is Market) {
      if (update == true) market.value = data;
      return data;
    }
    return null;
  }

  Future<Ticker?> getTicker(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return null;
    final data = await tickerController.getTicker(s);
    if (data is Ticker) {
      if (update == true) ticker.value = data;
      return data;
    }
    return null;
  }

  Future<List<List<num>>> getOhlcv(String? _symbol, {bool? update, String period = '1m'}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return [];
    final data = await ohlcvController.getOhlcv(s, period: period);
    if (data is List<List<num>>) {
      if (update == true) ohlcv.value = data;
      return data;
    }
    return [];
  }

  Future<OrderBook?> getOrderBook(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return null;
    final data = await orderBookController.getOrderBook(s);
    if (data is OrderBook) {
      if (update == true) orderBook.value = data;
      return data;
    }
    return null;
  }

  Future<OrderBook?> getDepth(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return null;
    final data = await orderBookController.getDepth(s);
    if (data is OrderBook) {
      if (update == true) depth.value = data;
      return data;
    }
    return null;
  }

  Future<List<Trade>> getTrades(String? _symbol, {bool? update}) async {
    final s = _symbol ?? symbol.value;
    if (s.isEmpty) return [];
    final data = await tradeController.getTrades(s);
    if (data is List<Trade>) {
      if (update == true) trades.value = data;
      return data;
    }
    return [];
  }

  void toggleShowKlineSetting() {
    showKlineSettings.value = !showKlineSettings.value;
  }
}
