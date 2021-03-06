import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/ccxt/trade.dart';
import '../../../../utils/handlers/timer.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/controllers/trade_controller.dart';
import '../../../commons/settings/controller/settings_controller.dart';

class TradeListController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final TradeController tradeController = Get.find<TradeController>();

  final RefreshController refreshController = RefreshController();

  final RxList<Trade> data = <Trade>[].obs;

  final TimerUtil timer = TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;
  late Worker watchSymbolWorker;

  @override
  void onInit() {
    super.onInit();
    watchSymbolWorker = ever(symbolController.currentSymbol, watchSymbol);

    timerWorker = debounce(
      settingsController.autoRefresh,
      TimerHandler.watchAutoRefresh(timer),
      time: const Duration(milliseconds: 800),
    );
    timer.setOnTimerTickCallback(
      TimerHandler.common(
        name: 'TradeListController',
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

  void getDataAndUpdate({String? symbol}) {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    if (_symbol.isEmpty) return;
    getTradesAnUpdate();
  }

  Future<void> getTradesAnUpdate({String? symbol, String? exchangeId}) async {
    final List<Trade>? result = await tradeController.getTrades(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    data.value = result;
  }
}
