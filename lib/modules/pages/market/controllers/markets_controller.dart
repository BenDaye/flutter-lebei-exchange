import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/handlers/timer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math';

class MarketsViewController extends GetxController with SingleGetTickerProviderMixin {
  final SettingsController settingsController = Get.find<SettingsController>();

  final selectedCategories = [false, true, false].obs;
  late PageController selectedCategoryPageController;
  final currentCategoryQuoteIndex = 0.obs;
  final currentCategoryQuotes = <Tab>[].obs;
  late TabController currentCategoryQuotesController;
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  final TickerController tickerController = Get.find<TickerController>();

  final tickers = <Ticker>[].obs;
  final sortType = SortType.UnSet.obs;
  final focusIndexes = <int>[].obs;
  final focusSymbols = <String>[].obs;

  final timer = new TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();
    selectedCategoryPageController = PageController(initialPage: selectedCategories.indexWhere((c) => c));
    currentCategoryQuotes.value = <Tab>[
      Tab(text: 'ALL'),
      Tab(text: 'USDT'),
      Tab(text: 'BTC'),
      Tab(text: 'ETH'),
    ];
    currentCategoryQuotesController = TabController(
      length: currentCategoryQuotes.length,
      vsync: this,
    );
    currentCategoryQuotesController.addListener(updateCurrentCategoryQuoteIndex);
    debounce(sortType, watchSortType, time: Duration(milliseconds: 300));
    debounce(focusIndexes, (List<int> _indexes) {
      if (_indexes.isEmpty) {
        focusSymbols.clear();
        return;
      }
      focusSymbols.value = tickers.getRange(_indexes.reduce(min), _indexes.reduce(max)).map((e) => e.symbol).toList();
    }, time: Duration(milliseconds: 800));

    ever(currentCategoryQuoteIndex, (_) => updateTickers());
    debounce(tickerController.tickers, (_) => updateTickers(), time: Duration(milliseconds: 300));
    ever(selectedCategories, (_) => updateTickers());

    timerWorker = debounce(
      settingsController.autoRefresh,
      TimerHandler.watchAutoRefresh(timer),
      time: Duration(milliseconds: 800),
    );
    timer.setOnTimerTickCallback(
      TimerHandler.common(
        name: 'MarketsViewController',
        action: getDataAndUpdate,
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
    TimerHandler.watchAutoRefresh(timer)(settingsController.autoRefresh.value);
    updateTickers();
  }

  @override
  void onClose() {
    timerWorker.dispose();
    timer.cancel();

    selectedCategoryPageController.dispose();
    currentCategoryQuotesController.removeListener(updateCurrentCategoryQuoteIndex);
    currentCategoryQuotesController.dispose();
    super.onClose();
  }

  void updateCurrentCategoryQuoteIndex() {
    currentCategoryQuoteIndex.value = currentCategoryQuotesController.index;
  }

  void updateTickers() {
    tickers.value = TickerHelper.filter(
      tickerController.tickers,
      quote: currentCategoryQuotes[currentCategoryQuoteIndex.value].text,
      standard: selectedCategories[1],
      margin: selectedCategories.last,
    );
    TickerHelper.sort(tickers, sortType: sortType.value);
    handleFocusSymbols();
  }

  void onChangeCategory(int index) {
    selectedCategories.value = List.filled(3, false)..fillRange(index, index + 1, true);
    index == 0 ? selectedCategoryPageController.jumpToPage(0) : selectedCategoryPageController.jumpToPage(1);
  }

  void watchSortType(SortType _sortType) {
    TickerHelper.sort(tickers, sortType: _sortType);
    handleFocusSymbols();
  }

  void handleFocusSymbols() {
    if (scrollController.offset.isEqual(0)) {
      if (focusIndexes.isNotEmpty) {
        focusSymbols.value =
            tickers.getRange(focusIndexes.reduce(min), focusIndexes.reduce(max)).map((e) => e.symbol).toList();
      }
    } else {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Future getDataAndUpdate() async {
    if (focusSymbols.isEmpty) return;
    final List<String> symbols = List<String>.from(focusSymbols.map((e) => e.replaceAll('/', '_'))).toList();

    tickerController.getTickersAndUpdatePartial(symbols: symbols);
  }
}
