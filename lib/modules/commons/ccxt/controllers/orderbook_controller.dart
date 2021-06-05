import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/orderbook.dart';
import 'package:get/get.dart';

class OrderBookController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  Future<OrderBook?> getOrderBook(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return null;
    final result = await ApiCcxt.orders(_exchangeId, symbol);
    if (!result.success) return null;

    return OrderBook.fromJson(result.data!);
  }

  Future<OrderBook?> getDepth(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return null;
    final result = await ApiCcxt.depth(_exchangeId, symbol);
    if (!result.success) return null;

    return OrderBook.fromJson(result.data!);
  }
}
