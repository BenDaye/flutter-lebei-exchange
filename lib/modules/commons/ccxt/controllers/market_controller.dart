import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  final markets = <Market>[].obs;
  final marketsMap = <String, Market>{}.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getMarkets(exchangeId: _exchangeId, update: true);
  }

  Future<Map<String, Market>> getMarkets({String? exchangeId, bool? update}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return {};
    final result = await ApiCcxt.markets(_exchangeId);
    if (!result.success) return {};

    final data = result.data!.map<String, Market>((key, value) => MapEntry(key, Market.fromJson(value)));
    if (update == true) {
      marketsMap.value = data;
      markets.value = data.values.toList();
    }
    return data;
  }

  Future<Market?> getMarket(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return null;
    final result = await ApiCcxt.market(_exchangeId, symbol);
    if (!result.success) return null;

    return Market.fromJson(result.data!);
  }

  String formatPriceByPrecision(Ticker ticker) {
    double _price = ticker.bid ?? 0.0;
    Market _market = markets.firstWhere((e) => e.symbol == ticker.symbol, orElse: () => Market.empty());
    return _price.toStringAsFixed(_market.precision.price.toInt());
  }
}
