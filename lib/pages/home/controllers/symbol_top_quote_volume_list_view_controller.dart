import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

enum SortType {
  ASC,
  DESC,
  UNSET,
}

class SymbolTopQuoteVolumeListViewController extends GetxController {
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
    this.watchTickers([]);
  }

  void watchTickers(List<Ticker> list) {
    final _tickers = List<Ticker>.from(tickerController.filterTickers(margin: true)).toList();
    _tickers.sort((a, b) => (b.quoteVolume ?? double.nan).compareTo((a.quoteVolume ?? double.nan)));
    tickers.value = NumUtil.greaterThan(_tickers.length, 20) ? _tickers.sublist(0, 20) : _tickers;
  }
}
