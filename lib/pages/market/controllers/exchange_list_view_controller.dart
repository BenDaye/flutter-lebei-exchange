import 'package:flustars/flustars.dart';
import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class TickerForRender {
  TickerForRender(
    this.exchangeId,
    this.price,
  );
  String exchangeId;
  String price;
}

enum SortType {
  NameAsc,
  NameDesc,
  PriceAsc,
  PriceDesc,
}

class ExchangeListViewController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();

  final exchangesMap = <String, Ticker>{}.obs;
  final exchanges = <TickerForRender>[].obs;

  final refreshing = true.obs;

  final sortType = SortType.PriceDesc.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.exchanges, watchExchanges);
  }

  @override
  void onReady() {
    super.onReady();
    watchExchanges(exchangeController.exchanges);
    ever(exchangesMap, watchExchangesMap);
    debounce(symbolController.currentSymbol, watchCurrentSymbol, time: Duration(milliseconds: 500));
    debounce(sortType, watchSortType, time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    refreshing.value = false;
    super.onClose();
  }

  Future watchCurrentSymbol(String _symbol) async {
    exchangesMap.clear();
    refreshing.value = false;
    await Future.delayed(Duration(milliseconds: 800));
    onRefresh(exchangeController.exchanges);
  }

  void watchExchanges(List<String> _exchanges) {
    exchangesMap.clear();
    onRefresh(_exchanges);
  }

  void watchSortType(SortType _sortType) {
    watchExchangesMap(exchangesMap);
  }

  void watchExchangesMap(Map<String, Ticker> _maps) {
    final List<TickerForRender> _exchanges = _maps.entries
        .map(
          (e) => TickerForRender(
            e.key,
            marketController.formatPriceByPrecision(e.value),
          ),
        )
        .toList();

    _exchanges.removeWhere((e) => NumUtil.isZero(NumUtil.getNumByValueStr(e.price)));

    _exchanges.sort(
      (a, b) {
        switch (sortType.value) {
          case SortType.PriceDesc:
            {
              return (NumUtil.getDoubleByValueStr(b.price) ?? double.nan).compareTo(
                (NumUtil.getDoubleByValueStr(a.price) ?? double.nan),
              );
            }
          case SortType.PriceAsc:
            {
              return (NumUtil.getDoubleByValueStr(a.price) ?? double.nan).compareTo(
                (NumUtil.getDoubleByValueStr(b.price) ?? double.nan),
              );
            }
          case SortType.NameAsc:
            {
              return a.exchangeId.compareTo(b.exchangeId);
            }
          case SortType.NameDesc:
            {
              return b.exchangeId.compareTo(a.exchangeId);
            }
          default:
            {
              return 0;
            }
        }
      },
    );

    exchanges.value = _exchanges;
  }

  Future onRefresh(List<String> _exchanges) async {
    if (_exchanges.isEmpty || symbolController.currentSymbol.isEmpty) return;
    refreshing.value = true;
    for (String exchange in _exchanges) {
      if (refreshing.isFalse) break;
      await Future.delayed(Duration(milliseconds: 500));
      if (refreshing.isFalse) break;

      getTicker(exchange);
    }
    refreshing.value = false;
  }

  Future getTicker(String _exchange) async {
    if (_exchange.isEmpty || symbolController.currentSymbol.isEmpty) return;

    final symbol = symbolController.currentSymbol.value.substring(0);
    final result = await ApiCcxt.ticker(_exchange, symbol, handleError: (_) => null);
    if (!result.success || result.data == null) return;

    if (symbol != symbolController.currentSymbol.value || refreshing.isFalse) return;

    exchangesMap.putIfAbsent(_exchange, () => Ticker.fromJson(result.data!));
  }
}
