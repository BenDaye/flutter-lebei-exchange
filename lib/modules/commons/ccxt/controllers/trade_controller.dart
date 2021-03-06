import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/trade.dart';
import '../../../../utils/http/handler/types.dart';
import 'exchange_controller.dart';
import 'symbol_controller.dart';

class TradeController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  Future<List<Trade>?> getTrades({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final HttpResult<List<dynamic>> result = await ApiCcxt.trades(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return List<Trade>.from(result.data!.map((dynamic r) => Trade.fromJson(r as Map<String, dynamic>)).toList());
    } catch (err) {
      Sentry.captureException(err);
    }
  }
}
