import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/models/ccxt/trade.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/trade_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TradeListController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final TradeController tradeController = Get.find<TradeController>();

  final RefreshController refreshController = RefreshController();

  final data = <Trade>[].obs;

  final timer = new TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();

    timerWorker = debounce(settingsController.autoRefresh, watchAutoRefresh, time: Duration(milliseconds: 800));
    timer.setOnTimerTickCallback(TimerHandler.common(name: 'TradeListController', action: getDataAndUpdate));
  }

  @override
  void onReady() {
    super.onReady();
    watchAutoRefresh(settingsController.autoRefresh.value);
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

  void watchSymbol(String _symbol) {
    if (_symbol.isEmpty) return;
    getDataAndUpdate(symbol: _symbol);
  }

  void getDataAndUpdate({String? symbol}) {
    final _symbol = symbol ?? symbolController.currentSymbol.value;
    if (_symbol.isEmpty) return;
    getTradesAnUpdate();
  }

  Future getTradesAnUpdate({String? symbol, String? exchangeId}) async {
    List<Trade>? result = await tradeController.getTrades(symbol: symbol, exchangeId: exchangeId);
    if (result == null) return;
    data.value = result;
  }
}
