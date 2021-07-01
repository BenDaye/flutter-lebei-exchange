import 'dart:math' show max, min;

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/ccxt/ticker.dart';
import '../../../../utils/handlers/timer.dart';
import '../../../commons/ccxt/controllers/ticker_controller.dart';
import '../../../commons/ccxt/helpers/ticker.dart';
import '../../../commons/settings/controller/settings_controller.dart';

class MarketsViewController extends GetxController with SingleGetTickerProviderMixin {
  final SettingsController settingsController = Get.find<SettingsController>();

  final RxList<bool> selectedCategories = <bool>[false, true, false].obs;
  late PageController selectedCategoryPageController;
  final RxInt currentCategoryQuoteIndex = 0.obs;
  final RxList<Tab> currentCategoryQuotes = <Tab>[].obs;
  late TabController currentCategoryQuotesController;
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  final TickerController tickerController = Get.find<TickerController>();

  final RxList<Ticker> tickers = <Ticker>[].obs;
  final Rx<SortType> sortType = SortType.unset.obs;
  final RxList<int> focusIndexes = <int>[].obs;
  final RxList<String> focusSymbols = <String>[].obs;

  final TimerUtil timer = TimerUtil(mInterval: 60 * 1000);
  late Worker timerWorker;

  @override
  void onInit() {
    super.onInit();
    selectedCategoryPageController = PageController(initialPage: selectedCategories.indexWhere((bool c) => c));
    currentCategoryQuotes.value = <Tab>[
      const Tab(text: 'ALL'),
      const Tab(text: 'USDT'),
      const Tab(text: 'BTC'),
      const Tab(text: 'ETH'),
    ];
    currentCategoryQuotesController = TabController(
      length: currentCategoryQuotes.length,
      vsync: this,
    );
    currentCategoryQuotesController.addListener(updateCurrentCategoryQuoteIndex);
    debounce(sortType, watchSortType, time: const Duration(milliseconds: 300));
    debounce(focusIndexes, (List<int> _indexes) {
      if (_indexes.isEmpty) {
        focusSymbols.clear();
        return;
      }
      focusSymbols.value =
          tickers.getRange(_indexes.reduce(min), _indexes.reduce(max)).map((Ticker e) => e.symbol).toList();
    }, time: const Duration(milliseconds: 800));

    ever(currentCategoryQuoteIndex, (_) => updateTickers());
    debounce(tickerController.tickers, (_) => updateTickers(), time: const Duration(milliseconds: 300));
    ever(selectedCategories, (_) => updateTickers());

    timerWorker = debounce(
      settingsController.autoRefresh,
      TimerHandler.watchAutoRefresh(timer),
      time: const Duration(milliseconds: 800),
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
    selectedCategories.value = List<bool>.filled(3, false)..fillRange(index, index + 1, true);
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
            tickers.getRange(focusIndexes.reduce(min), focusIndexes.reduce(max)).map((Ticker e) => e.symbol).toList();
      }
    } else {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Future<void> getDataAndUpdate() async {
    if (focusSymbols.isEmpty) return;
    final List<String> symbols = List<String>.from(focusSymbols.map((String e) => e.replaceAll('/', '_'))).toList();

    tickerController.getTickersAndUpdatePartial(symbols: symbols);
  }
}
