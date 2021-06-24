import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/models/ccxt/orderbook.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/orderbook_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderBookListController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final OrderBookController orderBookController = Get.find<OrderBookController>();

  final RefreshController refreshController = RefreshController();

  final Rx<OrderBook> data = OrderBook.empty().obs;

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

    super.onClose();
  }

  void watchSymbol(String _symbol) {
    if (_symbol.isEmpty) return;
    getDataAndUpdate(symbol: _symbol);
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
}
