import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class MarketController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  final markets = <Market>[].obs;
  final marketsMap = <String, Market>{}.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(marketsMap, watchMarketsMap);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getMarketsAndUpdate();
  }

  void watchMarketsMap(Map<String, Market> _marketsMap) {
    markets.value = _marketsMap.values.toList();
  }

  Future getMarketsAndUpdate() async {
    final _marketsMap = await getMarkets();
    if (_marketsMap == null) return;
    marketsMap.value = _marketsMap;
  }

  Future<Map<String, Market>?> getMarkets({String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final result = await ApiCcxt.markets(_exchangeId);
    if (!result.success) return null;

    try {
      return result.data!.map<String, Market>(
        (key, value) => MapEntry(key, Market.fromJson(value)),
      );
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  Future<Market?> getMarket(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return null;

    final result = await ApiCcxt.market(_exchangeId, symbol);
    if (!result.success) return null;

    try {
      return Market.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  String formatPriceByPrecision(dynamic value, String symbol) {
    final bool hasMarket = markets.any((e) => e.symbol == symbol);
    if (!hasMarket) return NumberFormatter.numberToString(value);

    return NumberHelper.decimalToPrecision(
      value,
      markets.firstWhere((e) => e.symbol == symbol, orElse: () => Market.empty()).precision.price,
      precisionMode: exchangeController.currentExchange.value.precisionMode,
      paddingMode: exchangeController.currentExchange.value.paddingMode,
    );
  }

  // String formatAmountByPrecision() {}
}
