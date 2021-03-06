import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/market.dart';
import '../../../../utils/formatter/number.dart';
import '../../../../utils/http/handler/types.dart';
import '../helpers/number.dart';
import 'exchange_controller.dart';
import 'symbol_controller.dart';

class MarketController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  final RxList<Market> markets = <Market>[].obs;
  final RxMap<String, Market> marketsMap = <String, Market>{}.obs;
  final Rx<Market> currentMarket = Market.empty().obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(marketsMap, watchMarketsMap);
    ever(symbolController.currentSymbol, watchCurrentSymbol);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    if (_exchangeId.isEmpty) {
      marketsMap.clear();
      return;
    }
    getMarketsAndUpdate();
  }

  void watchMarketsMap(Map<String, Market> _marketsMap) {
    markets.value = _marketsMap.values.toList();
    watchCurrentSymbol(symbolController.currentSymbol.value);
  }

  void watchCurrentSymbol(String symbol) {
    if (symbol.isEmpty) {
      currentMarket.value = Market.empty();
      return;
    }
    final String _symbol = symbol.replaceAll('_', '/');
    currentMarket.value = marketsMap.containsKey(_symbol) ? marketsMap[_symbol]! : Market.empty();
  }

  Future<void> getMarketsAndUpdate() async {
    final Map<String, Market>? _marketsMap = await getMarkets();
    if (_marketsMap == null) return;
    marketsMap.value = _marketsMap;
  }

  Future<Map<String, Market>?> getMarkets({String? exchangeId}) async {
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.markets(_exchangeId);
    if (!result.success) return null;

    try {
      return result.data!.map<String, Market>(
        (String key, dynamic value) => MapEntry<String, Market>(
          key,
          Market.fromJson(value as Map<String, dynamic>),
        ),
      );
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  Future<Market?> getMarket({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.market(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return Market.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  String formatPriceByPrecision(dynamic value, String symbol) {
    final bool hasMarket = markets.any((Market e) => e.symbol == symbol);
    if (!hasMarket) return NumberFormatter.numberToString(value);

    return NumberHelper.decimalToPrecision(
      value,
      markets.firstWhere((Market e) => e.symbol == symbol, orElse: () => Market.empty()).precision.price,
      precisionMode: exchangeController.currentExchange.value.precisionMode,
      paddingMode: exchangeController.currentExchange.value.paddingMode,
    );
  }

  String formatAmountByPrecision(dynamic value, String symbol) {
    final bool hasMarket = markets.any((Market e) => e.symbol == symbol);
    if (!hasMarket) return NumberFormatter.numberToString(value);

    return NumberHelper.decimalToPrecision(
      value,
      markets.firstWhere((Market e) => e.symbol == symbol, orElse: () => Market.empty()).precision.amount ?? 2,
      precisionMode: exchangeController.currentExchange.value.precisionMode,
      paddingMode: exchangeController.currentExchange.value.paddingMode,
    );
  }
}
