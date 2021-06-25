import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/models/ccxt/exchange.dart';
import 'package:flutter_lebei_exchange/models/ccxt/orderbook.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ohlcv_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/flutter_k_chart.dart';
import 'package:sentry/sentry.dart';

class ChartController extends GetxController with SingleGetTickerProviderMixin {
  final SettingsController settingsController = Get.find<SettingsController>();
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final OhlcvController ohlcvController = Get.find<OhlcvController>();
  final OrderBookController orderBookController = Get.find<OrderBookController>();

  final RxList<List<num>> ohlcv = <List<num>>[].obs;
  final Rx<OrderBook> depth = OrderBook.empty().obs;

  final RxList<KLineEntity> kline = <KLineEntity>[].obs;
  final RxList<DepthEntity> depthBids = <DepthEntity>[].obs;
  final RxList<DepthEntity> depthAsks = <DepthEntity>[].obs;

  static const List<String> defaultTimeframes = <String>['15m', '1h', '4h', '1d'];

  final RxList<Tab> timeframesTabs = <Tab>[].obs;
  final RxList<String> timeframesExtra = <String>[].obs;

  late TabController timeframesController;

  final RxString timeframe = ''.obs;

  final RxBool showExtra = false.obs;

  final RxBool showSettings = false.obs;
  final Rx<MainState> mainState = MainState.MA.obs;
  final Rx<SecondaryState> secondaryState = SecondaryState.MACD.obs;

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
        name: 'ChartController',
        action: getDataAndUpdate,
      ),
    );

    ever(exchangeController.timeframes, watchTimeframes);
    watchTimeframes(exchangeController.timeframes, init: true);
    debounce(timeframe, watchTimeframe, time: const Duration(microseconds: 300));

    ever(symbolController.currentSymbol, watchSymbol);
    ever(ohlcv, watchOhlcv);
    ever(depth, watchDepth);
    ever(showExtra, watchShowExtra);
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

    timeframesController.dispose();

    super.onClose();
  }

  void watchSymbol(String _symbol) {
    if (_symbol.isEmpty) return;
    getDataAndUpdate(symbol: _symbol);
  }

  void watchOhlcv(List<List<num>> _ohlcv) {
    try {
      final List<KLineEntity> list = List<KLineEntity>.from(
        _ohlcv
            .map(
              (List<num> item) => KLineEntity.fromCustom(
                time: item[0] as int,
                open: item[1].toDouble(),
                high: item[2].toDouble(),
                low: item[3].toDouble(),
                close: item[4].toDouble(),
                vol: item[5].toDouble(),
                amount: item[5].toDouble(),
              ),
            )
            .toList(),
      );
      DataUtil.calculate(list);
      kline.value = list;
      update(<String>['chart']);
    } catch (err) {
      Sentry.captureException(err);
    }
  }

  void watchDepth(OrderBook _depth) {
    try {
      final List<DepthEntity> _bids = List<DepthEntity>.from(
        _depth.bids.map(
          (List<double> item) => DepthEntity(item[0], item[1]),
        ),
      ).toList();
      final List<DepthEntity> _asks = List<DepthEntity>.from(
        _depth.asks.map(
          (List<double> item) => DepthEntity(item[0], item[1]),
        ),
      ).toList();

      depthBids.value = _bids;
      depthAsks.value = _asks;

      update(<String>['chart']);
    } catch (err) {
      Sentry.captureException(err);
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void watchShowExtra(bool _showExtra) {
    if (_showExtra) return;
    final int _moreIndex = timeframesTabs.indexWhere((Tab t) => t.key == const Key('MarketPage.Period.more'));
    final bool isExtra = timeframesExtra.contains(timeframe.value);
    if (!isExtra) {
      if (timeframesController.previousIndex != _moreIndex) {
        timeframesController.animateTo(timeframesController.previousIndex);

        timeframesTabs[_moreIndex] = Tab(
          key: const Key('MarketPage.Period.more'),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Text('MarketPage.Period.more'.tr, maxLines: 1),
              const Icon(Icons.signal_cellular_4_bar, size: 4)
            ],
          ),
        );
      }
      return;
    }
  }

  void getDataAndUpdate({String? symbol}) {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    if (_symbol.isEmpty) return;

    if (timeframe.value == 'depth') {
      getDepthAndUpdate();
    } else {
      getOhlcvAndUpdate();
    }
  }

  void timeframesControllerListener() {
    // ignore: unnecessary_raw_strings
    timeframe.value = RegExp(r"(?<=').*?(?=')")
        .stringMatch(
          timeframesTabs[timeframesController.index].key!.toString(),
        )!
        .split('.')
        .last;
  }

  void watchTimeframe(String _timeframe) {
    switch (_timeframe) {
      case 'depth':
        {
          getDepthAndUpdate();
        }
        break;
      case 'more':
        {
          // showExtra.value = true;
        }
        break;
      default:
        {
          getOhlcvAndUpdate();
        }
        break;
    }
  }

  void watchTimeframes(List<String> _timeframes, {bool init = false}) {
    if (!init) timeframesController.removeListener(timeframesControllerListener);

    if (_timeframes.length > 4) {
      final List<String> _timeframesRender = _timeframes
          .where(
            (String e) => defaultTimeframes.contains(e),
          )
          .toList();

      if (_timeframesRender.length < 4) {
        _timeframesRender.addAll(
          _timeframes
              .where(
                (String e) => !_timeframesRender.contains(e),
              )
              .take(4 - _timeframesRender.length)
              .toList(),
        );
      }

      timeframesExtra.value = _timeframes.where((String e) => !_timeframesRender.contains(e)).toList();

      timeframesTabs.value = _timeframesRender
          .map<Tab>(
            (String e) => Tab(
              text: 'MarketPage.Period.$e'.tr,
              key: Key('MarketPage.Period.$e'),
            ),
          )
          .toList();

      if (timeframesExtra.isNotEmpty) {
        timeframesTabs.add(
          Tab(
            key: const Key('MarketPage.Period.more'),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Text('MarketPage.Period.more'.tr, maxLines: 1),
                const Icon(Icons.signal_cellular_4_bar, size: 4)
              ],
            ),
          ),
        );
      }

      if (exchangeController.currentExchange.value.has.fetchOrderBook != HasType.hasFalse) {
        timeframesTabs.add(
          Tab(
            text: 'MarketPage.Period.depth'.tr,
            key: const Key('MarketPage.Period.depth'),
          ),
        );
      }

      timeframe.value = _timeframesRender.first;
    } else {
      timeframesTabs.value =
          _timeframes.map<Tab>((String e) => Tab(text: 'MarketPage.Period.$e'.tr, key: Key(e))).toList();
      if (_timeframes.isNotEmpty) {
        timeframe.value = _timeframes.first;
        if (exchangeController.currentExchange.value.has.fetchOrderBook != HasType.hasFalse) {
          timeframesTabs.add(
            Tab(
              text: 'MarketPage.Period.depth'.tr,
              key: const Key('MarketPage.Period.depth'),
            ),
          );
        }
      } else {
        timeframe.value = '';
      }
    }

    timeframesController = TabController(length: timeframesTabs.length, vsync: this);
    timeframesController.addListener(timeframesControllerListener);
  }

  Future<void> getOhlcvAndUpdate({String? symbol, String? exchangeId, String? timeframe}) async {
    final String _timeframe = timeframe ?? this.timeframe.value;
    if (_timeframe.isEmpty) return;

    final List<List<num>>? result =
        await ohlcvController.getOhlcv(symbol: symbol, exchangeId: exchangeId, period: _timeframe);
    if (result == null) return;
    ohlcv.value = result;
  }

  Future<void> getDepthAndUpdate({String? symbol, String? exchangeId}) async {
    final OrderBook? result = await orderBookController.getDepth(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    depth.value = result;
  }

  void handleClickTab(int _index) {
    final int _moreIndex = timeframesTabs.indexWhere((Tab t) => t.key == const Key('MarketPage.Period.more'));
    if (_moreIndex < 0) return;
    if (_index == _moreIndex) {
      showExtra.value = true;
      return;
    }
    timeframesTabs[_moreIndex] = Tab(
      key: const Key('MarketPage.Period.more'),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Text('MarketPage.Period.more'.tr, maxLines: 1),
          const Icon(Icons.signal_cellular_4_bar, size: 4)
        ],
      ),
    );
  }

  void onChangeTimeframeExtra(String _timeframe) {
    timeframe.value = _timeframe;
    final int _moreIndex = timeframesTabs.indexWhere((Tab t) => t.key == const Key('MarketPage.Period.more'));
    timeframesController.animateTo(_moreIndex);

    timeframesTabs[_moreIndex] = Tab(
      key: const Key('MarketPage.Period.more'),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Text('MarketPage.Period.$timeframe'.tr, maxLines: 1),
          const Icon(Icons.signal_cellular_4_bar, size: 4)
        ],
      ),
    );

    showExtra.value = false;
  }
}
