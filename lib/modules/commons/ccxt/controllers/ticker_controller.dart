import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/ticker.dart';
import '../../../../utils/http/handler/types.dart';
import 'exchange_controller.dart';
import 'symbol_controller.dart';

class TickerController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  final RxList<Ticker> tickers = <Ticker>[].obs;
  final RxMap<String, Ticker> tickersMap = <String, Ticker>{}.obs;
  final Rx<Ticker> currentTicker = Ticker.empty().obs;
  final RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(tickersMap, watchTickersMap);
    ever(tickers, watchTickers);
    ever(symbolController.currentSymbol, watchCurrentSymbol);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    if (_exchangeId.isEmpty) {
      tickersMap.clear();
      return;
    }
    getTickersAndUpdate();
  }

  void watchTickersMap(Map<String, Ticker> _tickersMap) {
    tickers.value = _tickersMap.values.toList();
    watchCurrentSymbol(symbolController.currentSymbol.value);
  }

  void watchTickers(List<Ticker> _tickers) {
    loading.value = _tickers.isEmpty;
  }

  void watchCurrentSymbol(String symbol) {
    if (symbol.isEmpty) {
      currentTicker.value = Ticker.empty();
      return;
    }
    final String _symbol = symbol.replaceAll('_', '/');
    currentTicker.value = tickersMap.containsKey(_symbol) ? tickersMap[_symbol]! : Ticker.empty();
  }

  Future<void> getTickersAndUpdate() async {
    final Map<String, Ticker>? _tickersMap = await getTickers();
    if (_tickersMap == null) return;
    tickersMap.value = _tickersMap;
  }

  Future<void> getTickersAndUpdatePartial({
    required List<String> symbols,
    String? exchangeId,
  }) async {
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty || symbols.isEmpty) return;

    final Map<String, Ticker>? _tickersMap = await getTickers(symbols: symbols);
    if (_tickersMap == null) return;

    _tickersMap.forEach((String key, Ticker value) {
      if (tickersMap.containsKey(key)) {
        tickersMap[key] = value;
      }
    });
  }

  Future<Map<String, Ticker>?> getTickers({String? exchangeId, List<String>? symbols}) async {
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.tickers(_exchangeId, symbols: symbols);
    if (!result.success) return null;

    try {
      return result.data!.map<String, Ticker>(
        (String key, dynamic value) => MapEntry<String, Ticker>(
          key,
          Ticker.fromJson(value as Map<String, dynamic>),
        ),
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

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.ticker(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return Ticker.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
