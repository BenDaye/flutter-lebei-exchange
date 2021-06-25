import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';

class ExchangeViewController extends GetxController {
  final ExchangeController exchangeController = Get.put(ExchangeController());
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  final RxString currentIndex = ''.obs;
  final RxList<String> indexes = <String>[].obs;
  final RxMap<String, int> indexMap = <String, int>{}.obs;

  final RxDouble itemHeight = 18.0.obs;
  final RxDouble totalHeight = 0.0.obs;
  final RxDouble currentOffsetY = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(indexes, watchIndexes);
    debounce(currentOffsetY, watchOffsetY, time: const Duration(milliseconds: 100));
    getIndexes();
    ever(currentIndex, watchCurrentIndex);
  }

  void watchIndexes(List<String> _indexes) {
    if (_indexes.isEmpty) return;
    totalHeight.value = _indexes.length * itemHeight.value;
  }

  void watchOffsetY(double offsetY) {
    final int _index = offsetY < 0
        ? 0
        : offsetY ~/ (itemHeight.value) > (indexes.length - 1)
            ? indexes.length - 1
            : offsetY ~/ (itemHeight.value);
    scrollToIndex(indexes[_index]);
    currentIndex.value = indexes[_index];
  }

  void watchCurrentIndex(String _currentIndex) {
    // ignore: avoid_print
    print(_currentIndex);
  }

  void getIndexes() {
    if (exchangeController.exchanges.isEmpty) return;
    final List<String> _indexes = List<String>.from(exchangeController.exchanges)
        .map((String e) => e.substring(0, 1).toUpperCase())
        .toSet()
        .toList();
    final Map<String, int> _indexMap = <String, int>{};
    for (final String tag in _indexes) {
      _indexMap.addIf(
        !_indexMap.containsKey(tag),
        tag,
        List<String>.from(exchangeController.exchanges)
            .indexWhere((String e) => e.substring(0, 1).toUpperCase() == tag),
      );
    }

    indexMap.value = _indexMap;
    indexes.value = _indexes;
    currentIndex.value = _indexes.first;
  }

  void scrollToIndex(String index) {
    itemScrollController.scrollTo(
      index: indexMap[index] ?? 0,
      duration: const Duration(milliseconds: 500),
    );
  }
}
