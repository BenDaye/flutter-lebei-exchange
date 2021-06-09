import 'package:carousel_slider/carousel_options.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
import 'package:get/get.dart';

class SymbolPopularGridViewController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final TickerController tickerController = Get.find<TickerController>();

  final currentIndex = 0.obs;
  final tickers = <Ticker>[].obs;
  final tickersForRender = <List<Ticker>>[].obs;

  final timer = new TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();
    timerWorker = debounce(settingsController.autoRefresh, watchAutoRefresh, time: Duration(milliseconds: 800));
    timer
        .setOnTimerTickCallback(TimerHandler.common(name: 'SymbolPopularGridViewController', action: getDataAndUpdate));
  }

  @override
  void onReady() {
    super.onReady();
    ever(tickerController.tickers, watchTickerControllerTickers);
    ever(tickers, watchTickers);
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    super.onClose();
  }

  void watchAutoRefresh(double _m) {
    if (timer.isActive()) timer.cancel();
    if (!_m.isEqual(0)) {
      timer.setInterval(_m.toInt() * 1000);
      timer.startTimer();
    }
  }

  void watchTickerControllerTickers(List<Ticker> _tickers) {
    List<Ticker> _list = List<Ticker>.from(_tickers)
        .where((t) => [
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
    _list.sort((a, b) => a.symbol.substring(0, 1).compareTo(b.symbol.substring(0, 1)));
    tickers.value = _list;
  }

  void watchTickers(List<Ticker> _tickers) {
    _tickers.sort((a, b) => a.symbol.substring(0, 1).compareTo(b.symbol.substring(0, 1)));
    tickersForRender.value = computeList(_tickers);
  }

  void onChangePageIndex(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

  List<List<T>> computeList<T>(List<T> l) {
    int _length = int.parse((l.length / 3).toStringAsFixed(0));
    Map<int, List<T>> _l = {};
    for (var i = 0; i < _length; i++) {
      int _endIndex = (i + 1) * 3 > l.length ? l.length : (i + 1) * 3;
      _l[i] = l.sublist(i * 3, _endIndex);
    }
    return _l.values.toList();
  }

  Future getDataAndUpdate() async {
    if (tickers.isEmpty) return;
    final tickerSymbols = tickers.map((e) => e.symbol).toList();

    final result = await tickerController.getTickers(symbols: tickerSymbols);
    if (result == null) return;

    tickers.value = result.values.toList();
  }
}
