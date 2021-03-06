import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../utils/http/handler/types.dart';
import 'exchange_controller.dart';
import 'symbol_controller.dart';

class OhlcvController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  Future<List<List<num>>?> getOhlcv({
    required String period,
    String? symbol,
    String? exchangeId,
  }) async {
    final String _symbol = symbol ?? symbolController.currentSymbol.value;
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_symbol.isEmpty || _exchangeId.isEmpty) return null;

    if (period.isEmpty) return null;

    final HttpResult<List<dynamic>> result = await ApiCcxt.ohlcv(_exchangeId, _symbol, period: period);
    if (!result.success) return null;

    try {
      return result.data!
          .map<List<num>>(
            (dynamic item) => (item as List<dynamic>)
                .map(
                  (dynamic e) => num.parse(e.toString()),
                )
                .toList(),
          )
          .toList();
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
