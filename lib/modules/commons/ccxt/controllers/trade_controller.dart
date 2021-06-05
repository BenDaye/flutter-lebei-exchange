import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/trade.dart';
import 'package:get/get.dart';

class TradeController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  Future<List<Trade>?> getTrades(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return [];
    final result = await ApiCcxt.trades(_exchangeId, symbol);
    if (!result.success) return [];

    return List<Trade>.from(result.data!.map((r) => Trade.fromJson(r)).toList());
  }
}
