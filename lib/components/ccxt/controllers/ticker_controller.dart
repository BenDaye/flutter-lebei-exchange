import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class TickerController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  final tickers = <Ticker>[].obs;
  final tickersMap = <String, Ticker>{}.obs;

  final sortRegexp =
      new RegExp(r'^BTC|ETH|DOT|XRP|LINK|BCH|LTC|ADA|EOS|TRX|XMR|IOTA|DASH|ETC|ZEC|USDC|PAX|WBTC|SHIB|DOGE|FIL');

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getTickers(exchangeId: _exchangeId, update: true);
  }

  Future<Map<String, Ticker>> getTickers({String? exchangeId, bool? update, List<String>? symbols}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return {};
    final result = await ApiCcxt.tickers(_exchangeId, symbols: symbols);
    if (!result.success) return {};

    final data = result.data!.map<String, Ticker>((key, value) => MapEntry(key, Ticker.fromJson(value)));
    if (update == true) {
      tickersMap.value = data;
      tickers.value = data.values.toList();
    }
    return data;
  }

  Future<Ticker?> getTicker(String symbol, {String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (symbol.isEmpty || _exchangeId.isEmpty) return null;
    final result = await ApiCcxt.ticker(_exchangeId, symbol);
    if (!result.success) return null;

    return Ticker.fromJson(result.data!);
  }

  List<Ticker> filterTickers({String? quote, bool? unknown = false, bool? margin = false, bool? standard = true}) {
    List<Ticker> _tickers = List<Ticker>.from(tickers);

    if (unknown == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r'[a-z]')));
    if (standard == false) _tickers.removeWhere((t) => !t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));
    if (margin == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));

    if (quote != null && quote.isNotEmpty && quote != 'ALL')
      _tickers = _tickers.where((t) => t.symbol.endsWith(quote)).toList();

    _tickers.sort((a, b) {
      if (a.symbol.startsWith(sortRegexp) && !b.symbol.startsWith(sortRegexp)) {
        return -1;
      } else if (!a.symbol.startsWith(sortRegexp) && b.symbol.startsWith(sortRegexp)) {
        return 1;
      } else {
        return a.symbol.compareTo(b.symbol);
      }
    });
    return _tickers;
  }
}
