import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/trade.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class TradeController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  Future<List<Trade>?> getTrades({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final result = await ApiCcxt.trades(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return List<Trade>.from(result.data!.map((r) => Trade.fromJson(r)).toList());
    } catch (err) {
      Sentry.captureException(err);
    }
  }
}
