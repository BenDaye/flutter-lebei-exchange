import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:get/get.dart';

class SymbolTopPercentageListController extends GetxController {
  final TickerController tickerController = Get.find<TickerController>();

  final RxList<Ticker> tickers = <Ticker>[].obs;
  final Rx<SortType> sortType = SortType.percentageDesc.obs;

  @override
  void onInit() {
    super.onInit();
    ever(tickerController.tickers, watchTickers);
    debounce(sortType, watchSortType, time: const Duration(milliseconds: 300));
  }

  @override
  void onReady() {
    super.onReady();
    watchTickers(<Ticker>[]);
  }

  void watchTickers(List<Ticker> list) {
    final List<Ticker> _tickers = TickerHelper.filter(tickerController.tickers, margin: true)
        .where((Ticker t) => t.symbol.endsWith('USDT') || t.symbol.endsWith('BTC'))
        .toList();
    _tickers.sort((Ticker a, Ticker b) =>
        (b.percentage.isNaN ? 0 : b.percentage).compareTo(a.percentage.isNaN ? 0 : a.percentage));
    tickers.value = NumUtil.greaterThan(_tickers.length, 8) ? _tickers.sublist(0, 8) : _tickers;
  }

  void watchSortType(SortType _sortType) {
    TickerHelper.sort(tickers, sortType: _sortType);
  }
}
