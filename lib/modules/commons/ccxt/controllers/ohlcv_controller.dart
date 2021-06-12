import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class OhlcvController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  Future<List<List<num>>?> getOhlcv({String? symbol, String? exchangeId, required String period}) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    if (period.isEmpty) return null;

    final HttpResult<List<dynamic>> result = await ApiCcxt.ohlcv(_exchangeId, _symbol, period: period);
    if (!result.success) return null;

    try {
      return List<List<num>>.from(result.data!).map((List<num> item) => List<num>.from(item)).toList();
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
