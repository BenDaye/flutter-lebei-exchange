import 'package:carousel_slider/carousel_options.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class SymbolPopularGridViewController extends GetxController {
  final TickerController tickerController = Get.find<TickerController>();
  final currentIndex = 0.obs;
  final tickers = <Ticker>[].obs;
  final tickersForRender = <List<Ticker>>[].obs;

  final timer = new TimerUtil(mInterval: 60 * 1000);

  @override
  void onInit() {
    super.onInit();
    timer.setOnTimerTickCallback(handleTimer);
  }

  @override
  void onReady() {
    super.onReady();
    timer.startTimer();
    ever(tickerController.tickers, watchTickerControllerTickers);
    ever(tickers, watchTickers);
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void watchTickerControllerTickers(List<Ticker> _tickers) {
    tickers.value = List<Ticker>.from(tickerController.tickers)
        .where((t) =>
            t.symbol.startsWith(RegExp(r"BTC|ETH|XCH|DOT|SHIB|DOGE")) &&
            t.symbol.endsWith('USDT') &&
            !RegExp(r"[1-9]\d*[LS]").hasMatch(t.symbol))
        .take(6)
        .toList();
  }

  void watchTickers(List<Ticker> _tickers) {
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

  Future handleTimer(int tick) async {
    print('SymbolPopularGridViewController getTickers ==> $tick');
    if (tickers.isEmpty) return;
    final tickerSymbols = tickers.map((e) => e.symbol).toList();
    final result = await tickerController.getTickers(symbols: tickerSymbols);
    tickers.value = result.values.toList();
  }
}
