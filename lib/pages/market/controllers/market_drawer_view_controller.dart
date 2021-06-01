import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class MarketDrawerViewController extends GetxController with SingleGetTickerProviderMixin {
  final TickerController tickerController = Get.find<TickerController>();
  final SymbolController symbolController = Get.find<SymbolController>();

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

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(tabControllerListener);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    ever(tickerController.tickers, wacthTickers);
    debounce(currentTabIndex, watchCurrenctTabIndex, time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void tabControllerListener() {
    currentTabIndex.value = tabController.index;
  }

  void watchCurrenctTabIndex(int _index) {
    switch (_index) {
      case 0:
        {
          tickers.value = List<Ticker>.from(symbolController.favoriteSymbols
              .map((s) => tickerController.tickers.firstWhere((t) => t.symbol == s))
              .toList());
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
