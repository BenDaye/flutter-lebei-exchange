import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/ticker.dart';
import '../../../../utils/formatter/number.dart';
import '../../../../utils/http/handler/types.dart';
import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/helpers/ticker.dart';

class TickerForRender {
  TickerForRender(
    this.exchangeId,
    this.price,
  );
  String exchangeId;
  String price;
}

class ExchangeListViewController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final RxMap<String, Ticker> exchangesMap = <String, Ticker>{}.obs;
  final RxList<TickerForRender> exchanges = <TickerForRender>[].obs;

  final RxBool refreshing = true.obs;

  final Rx<SortType> sortType = SortType.priceDesc.obs;

  late Worker exchangesWorker;
  late Worker currentSymbolWorker;

  @override
  void onInit() {
    super.onInit();

    exchangesWorker = ever(exchangeController.exchanges, watchExchanges);
    currentSymbolWorker = debounce(
      symbolController.currentSymbol,
      watchCurrentSymbol,
      time: const Duration(milliseconds: 500),
    );

    ever(exchangesMap, watchExchangesMap);
    debounce(sortType, watchSortType, time: const Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    exchangesWorker.dispose();
    currentSymbolWorker.dispose();
    refreshing.value = false;
    refreshController.refreshCompleted();
    refreshController.dispose();
    super.onClose();
  }

  Future<void> watchCurrentSymbol(String _symbol) async {
    await beforeRefresh();
    onRefresh(exchangeController.exchanges);
  }

  Future<void> watchExchanges(List<String> _exchanges) async {
    await beforeRefresh();
    onRefresh(_exchanges);
  }

  void watchSortType(SortType _sortType) {
    watchExchangesMap(exchangesMap);
  }

  void watchExchangesMap(Map<String, Ticker> _maps) {
    final List<TickerForRender> _exchanges = _maps.entries
        .map(
          (MapEntry<String, Ticker> e) => TickerForRender(
            e.key,
            marketController.formatPriceByPrecision(TickerHelper.getValuablePrice(e.value), e.value.symbol),
          ),
        )
        .toList();

    _exchanges.removeWhere((TickerForRender e) => e.price == NumberFormatter.unknownNumberToString);

    _exchanges.sort(
      (TickerForRender a, TickerForRender b) {
        switch (sortType.value) {
          case SortType.priceDesc:
            {
              return (NumUtil.getDoubleByValueStr(b.price) ?? 0).compareTo(
                NumUtil.getDoubleByValueStr(a.price) ?? 0,
              );
            }
          case SortType.priceAsc:
            {
              return (NumUtil.getDoubleByValueStr(a.price) ?? 0).compareTo(
                NumUtil.getDoubleByValueStr(b.price) ?? 0,
              );
            }
          case SortType.exchangeAsc:
            {
              return a.exchangeId.compareTo(b.exchangeId);
            }
          case SortType.exchangeDesc:
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

  Future<void> beforeRefresh() async {
    exchangesMap.clear();
    refreshing.value = false;
    // ignore: always_specify_types
    await Future.delayed(const Duration(milliseconds: 800));
    refreshing.value = true;
  }

  Future<void> onRefresh(List<String> _exchanges) async {
    if (_exchanges.isEmpty || symbolController.currentSymbol.isEmpty) return;

    for (final String exchange in _exchanges) {
      if (refreshing.isFalse) break;
      // ignore: always_specify_types
      await Future.delayed(const Duration(milliseconds: 500));
      if (refreshing.isFalse) break;

      getTicker(exchange);
    }

    refreshing.value = false;
  }

  Future<void> onRefreshExchange() async {
    await beforeRefresh();
    await onRefresh(exchangeController.exchanges);
    refreshController.refreshCompleted();
  }

  Future<void> getTicker(String _exchange) async {
    if (_exchange.isEmpty || symbolController.currentSymbol.isEmpty) return;

    final String symbol = symbolController.currentSymbol.value.substring(0);
    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.ticker(_exchange, symbol, handleError: (_) => null);
    if (!result.success || result.data == null) return;

    if (symbol != symbolController.currentSymbol.value || refreshing.isFalse) return;

    exchangesMap.putIfAbsent(_exchange, () => Ticker.fromJson(result.data!));
  }
}
