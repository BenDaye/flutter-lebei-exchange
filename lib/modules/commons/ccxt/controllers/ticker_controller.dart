import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class TickerController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  final tickers = <Ticker>[].obs;
  final tickersMap = <String, Ticker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(tickersMap, watchTickersMap);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getTickersAndUpdate();
  }

  void watchTickersMap(Map<String, Ticker> _tickersMap) {
    tickers.value = _tickersMap.values.toList();
  }

  Future getTickersAndUpdate() async {
    final _tickersMap = await getTickers();
    if (_tickersMap == null) return;
    tickersMap.value = _tickersMap;
  }

  Future<Map<String, Ticker>?> getTickers({String? exchangeId, List<String>? symbols}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final result = await ApiCcxt.tickers(_exchangeId, symbols: symbols);
    if (!result.success) return null;

    try {
      return result.data!.map<String, Ticker>(
        (key, value) => MapEntry(key, Ticker.fromJson(value)),
      );
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  Future<Ticker?> getTicker({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final result = await ApiCcxt.ticker(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return Ticker.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
