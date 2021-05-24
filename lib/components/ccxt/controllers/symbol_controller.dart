import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';

class SymbolController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final symbols = <String>[].obs;
  final currentSymbol = ''.obs;

  final favoriteSymbols = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(currentSymbol, watchCurrentSymbol);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    this.getSymbols(exchangeId: _exchangeId, update: true);
  }

  void watchCurrentSymbol(String _symbol) {
    print(_symbol);
  }

  Future<List<String>> getSymbols({String? exchangeId, bool? update}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return [];
    final result = await ApiCcxt.symbols(_exchangeId);
    if (!result.success) return [];

    final data = List<String>.from(result.data!);
    if (update == true) {
      symbols.value = data;
    }
    return data;
  }

  void toggleFavoriteSymbol(String symbol) {
    if (symbols.contains(symbol)) {
      if (favoriteSymbols.contains(symbol)) {
        favoriteSymbols.remove(symbol);
        Get.showSnackbar(
          GetBar(
            message: '已将$symbol移除自选',
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.GROUNDED,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        favoriteSymbols.add(symbol);
        Get.showSnackbar(
          GetBar(
            message: '已将$symbol添加自选',
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.GROUNDED,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
