import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class MarketDrawerViewController extends GetxController with SingleGetTickerProviderMixin {
  final TickerController tickerController = Get.find<TickerController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  TextEditingController textEditingController = TextEditingController();

  final tabs = [
    'MarketDrawer.Tab.Favorites',
    'MarketDrawer.Tab.All',
    'MarketDrawer.Tab.USDT',
    'MarketDrawer.Tab.BTC',
    'MarketDrawer.Tab.ETH',
  ];
  late TabController tabController;
  final currentTabIndex = 0.obs;

  final tickers = <Ticker>[].obs;

  late Worker queryWorker;
  final query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(tabControllerListener);
    textEditingController.addListener(watchEditing);
  }

  @override
  void onReady() {
    super.onReady();
    ever(tickerController.tickers, wacthTickers);
    debounce(currentTabIndex, watchCurrenctTabIndex, time: Duration(milliseconds: 300));
    watchCurrenctTabIndex(0);

    queryWorker = debounce(query, watchQuery, time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    queryWorker.dispose();
    tabController.dispose();
    textEditingController.removeListener(watchEditing);
    super.onClose();
  }

  void watchEditing() {
    query.value = textEditingController.text;
  }

  void watchQuery(String _query) {
    if (_query.isEmpty) return watchCurrenctTabIndex(currentTabIndex.value);
    final _tickers = List<Ticker>.from(tickerController.filterTickers())
        .where((e) => e.symbol.startsWith(_query.trim().toUpperCase()))
        .toList();
    tickers.value = _tickers;
  }

  void tabControllerListener() {
    currentTabIndex.value = tabController.index;
  }

  void watchCurrenctTabIndex(int _index) {
    switch (_index) {
      case 0:
        {
          tickers.value = List<Ticker>.from(
            symbolController.favoriteSymbols
                .map(
                  (s) => tickerController.tickers.firstWhere(
                    (t) => t.symbol == s.replaceAll('_', '/'),
                  ),
                )
                .toList(),
          );
          break;
        }
      case 1:
        {
          tickers.value = List<Ticker>.from(tickerController.filterTickers());
          break;
        }
      case 2:
        {
          tickers.value = List<Ticker>.from(tickerController.filterTickers(quote: 'USDT'));
          break;
        }
      case 3:
        {
          tickers.value = List<Ticker>.from(tickerController.filterTickers(quote: 'BTC'));
          break;
        }
      case 4:
        {
          tickers.value = List<Ticker>.from(tickerController.filterTickers(quote: 'ETH'));
          break;
        }
      default:
        break;
    }
  }

  void wacthTickers(List<Ticker> _tickers) {
    watchCurrenctTabIndex(tabController.index);
  }
}
