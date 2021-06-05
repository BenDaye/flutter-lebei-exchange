import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarketsViewController extends GetxController with SingleGetTickerProviderMixin {
  final selectedCategories = [false, true, false].obs;
  late PageController selectedCategoryPageController;
  final currentCategoryQuoteIndex = 0.obs;
  final currentCategoryQuotes = <Tab>[].obs;
  late TabController currentCategoryQuotesController;
  RefreshController refreshController = RefreshController();

  final TickerController tickerController = Get.find<TickerController>();

  final tickers = <Ticker>[].obs;

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
  }

  @override
  void onReady() {
    super.onReady();
    updateTickers();
    ever(currentCategoryQuoteIndex, (_) => updateTickers());
    ever(tickerController.tickers, (_) => updateTickers());
    ever(selectedCategories, (_) => updateTickers());
  }

  void updateCurrentCategoryQuoteIndex() {
    currentCategoryQuoteIndex.value = currentCategoryQuotesController.index;
  }

  void updateTickers() {
    tickers.value = tickerController.filterTickers(
        quote: currentCategoryQuotes[currentCategoryQuoteIndex.value].text,
        standard: selectedCategories[1],
        margin: selectedCategories.last);
  }

  void onChangeCategory(int index) {
    selectedCategories.value = List.filled(3, false)..fillRange(index, index + 1, true);
    index == 0 ? selectedCategoryPageController.jumpToPage(0) : selectedCategoryPageController.jumpToPage(1);
  }

  @override
  void onClose() {
    selectedCategoryPageController.dispose();
    currentCategoryQuotesController.removeListener(updateCurrentCategoryQuoteIndex);
    currentCategoryQuotesController.dispose();
    super.onClose();
  }
}
