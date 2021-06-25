import 'package:carousel_slider/carousel_options.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';

class SymbolPopularGridViewController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final TickerController tickerController = Get.find<TickerController>();

  final RxInt currentIndex = 0.obs;
  final RxList<Ticker> tickers = <Ticker>[].obs;
  final RxList<List<Ticker>> tickersForRender = <List<Ticker>>[].obs;

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
        name: 'SymbolPopularGridViewController',
        action: getDataAndUpdate,
      ),
    );

    debounce(
      tickerController.tickers,
      watchTickerControllerTickers,
      time: const Duration(milliseconds: 300),
    );
    ever(tickers, watchTickers);
  }

  @override
  void onReady() {
    super.onReady();
    watchTickerControllerTickers(tickerController.tickers);
    Future<void>.delayed(
      Duration(seconds: settingsController.autoRefresh.value.toInt()),
      () => TimerHandler.watchAutoRefresh(timer)(settingsController.autoRefresh.value),
    );
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    super.onClose();
  }

  void watchTickerControllerTickers(List<Ticker> _tickers) {
    List<Ticker> _list = List<Ticker>.from(_tickers)
        .where((Ticker t) => <String>[
              'BTC/USDT',
              'ETH/USDT',
              'DOT/USDT',
              'XRP/USDT',
              'LINK/USDT',
              'LTC/USDT',
              'ADA/USDT',
              'EOS/USDT',
              'SHIB/USDT',
              'DOGE/USDT',
              'FIL/USDT',
            ].contains(t.symbol))
        .toList();
    _list = _list.length > 9 ? _list.take(9).toList() : _list;
    _list.sort((Ticker a, Ticker b) => a.symbol.substring(0, 1).compareTo(b.symbol.substring(0, 1)));
    tickers.value = _list;
  }

  void watchTickers(List<Ticker> _tickers) {
    _tickers.sort((Ticker a, Ticker b) => a.symbol.substring(0, 1).compareTo(b.symbol.substring(0, 1)));
    tickersForRender.value = computeList(_tickers);
  }

  void onChangePageIndex(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

  List<List<T>> computeList<T>(List<T> l) {
    final int _length = int.parse((l.length / 3).toStringAsFixed(0));
    final Map<int, List<T>> _l = <int, List<T>>{};
    for (int i = 0; i < _length; i++) {
      final int _endIndex = (i + 1) * 3 > l.length ? l.length : (i + 1) * 3;
      _l[i] = l.sublist(i * 3, _endIndex);
    }
    return _l.values.toList();
  }

  Future<void> getDataAndUpdate() async {
    if (tickers.isEmpty) return;
    final List<String> tickerSymbols = tickers.map((Ticker e) => e.symbol.replaceAll('/', '_')).toList();

    tickerController.getTickersAndUpdatePartial(symbols: tickerSymbols);
  }
}
