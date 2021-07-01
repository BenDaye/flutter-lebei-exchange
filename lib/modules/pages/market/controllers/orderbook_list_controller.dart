import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/ccxt/orderbook.dart';
import '../../../../utils/handlers/timer.dart';
import '../../../commons/ccxt/controllers/orderbook_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/settings/controller/settings_controller.dart';

class OrderBookListController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final OrderBookController orderBookController = Get.find<OrderBookController>();

  final RefreshController refreshController = RefreshController();

  final Rx<OrderBook> data = OrderBook.empty().obs;
  final RxList<List<double>> bids = <List<double>>[].obs;
  final RxList<List<double>> asks = <List<double>>[].obs;

  final TimerUtil timer = TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;
  late Worker watchSymbolWorker;

  @override
  void onInit() {
    super.onInit();
    watchSymbolWorker = ever(symbolController.currentSymbol, watchSymbol);
    ever(data, watchData);

    timerWorker = debounce(
      settingsController.autoRefresh,
      TimerHandler.watchAutoRefresh(timer),
      time: const Duration(milliseconds: 800),
    );
    timer.setOnTimerTickCallback(
      TimerHandler.common(
        name: 'OrderBookListController',
        action: getDataAndUpdate,
      ),
    );
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

    watchSymbolWorker.dispose();
    super.onClose();
  }

  void watchSymbol(String _symbol) {
    if (_symbol.isEmpty) return;
    getDataAndUpdate(symbol: _symbol);
  }

  void watchData(OrderBook _data) {
    if (_data.symbol == OrderBook.empty().symbol) return;
    handleData();
  }

  void getDataAndUpdate({String? symbol}) {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    if (_symbol.isEmpty) return;
    getOrderBookAnUpdate();
  }

  Future<void> getOrderBookAnUpdate({String? symbol, String? exchangeId}) async {
    final OrderBook? result = await orderBookController.getOrderBook(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    data.value = result;
  }

  void handleData() {
    final List<List<double>> _bids = List<List<double>>.from(data.value.bids);
    final List<List<double>> _asks = List<List<double>>.from(data.value.asks);
    _bids.sort((List<double> a, List<double> b) => b.first.compareTo(a.first));
    _asks.sort((List<double> a, List<double> b) => a.first.compareTo(b.first));
    final double _bidsTotalAmount = _bids.fold(0, (double t, List<double> e) => t + e.last);
    final double _asksTotalAmount = _asks.fold(0, (double t, List<double> e) => t + e.last);

    final List<List<double>> __bids = <List<double>>[];
    final List<List<double>> __asks = <List<double>>[];

    for (final List<double> bid in _bids) {
      __bids.add(
        <double>[
          bid.first,
          bid.last,
          _bids
                  .where((List<double> e) => e.first >= bid.first)
                  .fold<double>(0, (double t, List<double> e) => t + e.last) /
              _bidsTotalAmount,
        ],
      );
    }

    for (final List<double> ask in _asks) {
      __asks.add(
        <double>[
          ask.first,
          ask.last,
          _asks
                  .where((List<double> e) => e.first <= ask.first)
                  .fold<double>(0, (double t, List<double> e) => t + e.last) /
              _asksTotalAmount,
        ],
      );
    }

    bids.value = __bids;
    asks.value = __asks;
  }
}
