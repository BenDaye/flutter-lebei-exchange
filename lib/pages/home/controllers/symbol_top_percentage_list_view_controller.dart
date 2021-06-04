import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

enum SortType {
  ASC,
  DESC,
  UNSET,
}

class SymbolTopPercentageListViewController extends GetxController {
  final nameSortType = SortType.UNSET.obs;
  final tickers = <Ticker>[].obs;

  final TickerController tickerController = Get.find<TickerController>();

  @override
  void onInit() {
    super.onInit();
    ever(tickerController.tickers, watchTickers);
  }

  @override
  void onReady() {
    super.onReady();
    watchTickers([]);
  }

  void watchTickers(List<Ticker> list) {
    final _tickers = List<Ticker>.from(tickerController.filterTickers(margin: true))
        .where((t) => t.symbol.endsWith("USDT") || t.symbol.endsWith("BTC"))
        .toList();
    _tickers.sort((a, b) => (b.percentage ?? double.nan).compareTo((a.percentage ?? double.nan)));
    tickers.value = NumUtil.greaterThan(_tickers.length, 8) ? _tickers.sublist(0, 8) : _tickers;
  }
}
