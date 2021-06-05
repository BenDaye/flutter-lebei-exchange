import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';

class OhlcvController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  Future<List<List<num>>> getOhlcv(String symbol, {String? exchangeId, String period = '1m'}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return [];
    final result = await ApiCcxt.ohlcv(_exchangeId, symbol, period: period);
    if (!result.success) return [];

    return List.from(result.data!).map((item) => List<num>.from(item)).toList();
  }
}
