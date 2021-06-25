import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';

class SearchController extends GetxController {
  final SymbolController symbolController = Get.find<SymbolController>();
  final FloatingSearchBarController floatingSearchBarController = FloatingSearchBarController();

  final RxList<String> symbols = <String>[].obs;

  final RxString query = ''.obs;

  late Worker queryWorker;

  @override
  void onInit() {
    super.onInit();
    queryWorker = debounce(query, watchQuery, time: const Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
    floatingSearchBarController.open();
  }

  @override
  void onClose() {
    floatingSearchBarController.dispose();
    queryWorker.dispose();
    super.onClose();
  }

  void onChangeQuery(String _query) {
    query.value = _query;
  }

  void watchQuery(String _query) {
    if (_query.isEmpty) {
      return symbols.clear();
    }
    final List<String> _symbol = List<String>.from(
      symbolController.symbols.where(
        (String e) => e.startsWith(_query.trim().toUpperCase()),
      ),
    ).toList();
    _symbol.removeWhere((String e) => e.contains(RegExp(r'[1-9]\d*[LS]')));
    _symbol.sort((String a, String b) => a.compareTo(b));

    symbols.value = _symbol;
  }
}
