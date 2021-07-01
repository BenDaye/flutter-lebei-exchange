import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

import '../../../../models/ccxt/ticker.dart';
import '../../../../utils/formatter/number.dart';
import '../../../commons/ccxt/controllers/ticker_controller.dart';
import '../../../commons/ccxt/helpers/ticker.dart';

class SymbolTopBaseVolumeListController extends GetxController {
  final TickerController tickerController = Get.find<TickerController>();

  final RxList<Ticker> tickers = <Ticker>[].obs;
  final Rx<SortType> sortType = SortType.baseVolDesc.obs;

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
    final List<Ticker> _tickers = TickerHelper.filter(tickerController.tickers, margin: true);
    _tickers.sort(
      (Ticker a, Ticker b) => (NumberFormatter.stringToNumber(b.baseVolume)).compareTo(
        NumberFormatter.stringToNumber(a.baseVolume),
      ),
    );
    tickers.value = NumUtil.greaterThan(_tickers.length, 8) ? _tickers.sublist(0, 8) : _tickers;
  }

  void watchSortType(SortType _sortType) {
    TickerHelper.sort(tickers, sortType: _sortType);
  }
}
