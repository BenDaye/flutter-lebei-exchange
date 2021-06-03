import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExchangeViewController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  final indexes = <String>[].obs;
  final indexMap = <String, int>{}.obs;

  final itemHeight = 18.0.obs;
  final totalHeight = 0.0.obs;
  final currentOffsetY = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(indexes, watchIndexes);
    debounce(currentOffsetY, watchOffsetY, time: Duration(milliseconds: 100));
    getIndexes();
    itemPositionsListener.itemPositions.addListener(watchItemPositions);
  }

  @override
  void onClose() {
    itemPositionsListener.itemPositions.removeListener(watchItemPositions);
    super.onClose();
  }

  void watchIndexes(List<String> _indexes) {
    if (_indexes.isEmpty) return;
    totalHeight.value = _indexes.length * itemHeight.value;
  }

  void watchOffsetY(double offsetY) {
    int _index = offsetY < 0
        ? 0
        : offsetY ~/ (itemHeight.value) > (indexes.length - 1)
            ? indexes.length - 1
            : offsetY ~/ (itemHeight.value);
    scrollToIndex(indexes[_index]);
  }

  void watchItemPositions() {
    // print(itemPositionsListener.itemPositions.value);
  }

  void getIndexes() {
    if (exchangeController.exchanges.isEmpty) return;
    List<String> _indexes =
        List<String>.from(exchangeController.exchanges).map((e) => e.substring(0, 1).toUpperCase()).toSet().toList();
    Map<String, int> _indexMap = {};
    for (String tag in _indexes) {
      _indexMap.addIf(
        !_indexMap.containsKey(tag),
        tag,
        List<String>.from(exchangeController.exchanges).indexWhere((e) => e.substring(0, 1).toUpperCase() == tag),
      );
    }

    indexMap.value = _indexMap;
    indexes.value = _indexes;
  }

  void scrollToIndex(String index) {
    itemScrollController.scrollTo(
      index: indexMap[index] ?? 0,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
