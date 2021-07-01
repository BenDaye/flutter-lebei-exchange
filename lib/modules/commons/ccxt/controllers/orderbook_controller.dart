import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/orderbook.dart';
import '../../../../utils/http/handler/types.dart';
import 'exchange_controller.dart';
import 'symbol_controller.dart';

class OrderBookController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  Future<OrderBook?> getOrderBook({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.orderbook(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return OrderBook.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
    }
  }

  Future<OrderBook?> getDepth({String? symbol, String? exchangeId}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.depth(_exchangeId, _symbol);
    if (!result.success) return null;

    try {
      return OrderBook.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
    }
  }
}
