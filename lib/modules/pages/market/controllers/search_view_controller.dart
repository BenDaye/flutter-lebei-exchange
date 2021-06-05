import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/symbol_controller.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchViewController extends GetxController {
  final SymbolController symbolController = Get.find<SymbolController>();
  final FloatingSearchBarController floatingSearchBarController = FloatingSearchBarController();

  final symbols = <String>[].obs;

  final query = ''.obs;

  late Worker queryWorker;

  @override
  void onInit() {
    super.onInit();
    queryWorker = debounce(query, watchQuery, time: Duration(milliseconds: 500));
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
    final _symbol = List<String>.from(
      symbolController.symbols.where(
        (e) => e.startsWith(_query.trim().toUpperCase()),
      ),
    ).toList();
    _symbol.removeWhere((e) => e.contains(RegExp(r"[1-9]\d*[LS]")));
    _symbol.sort((a, b) => a.compareTo(b));

    symbols.value = _symbol;
  }
}
