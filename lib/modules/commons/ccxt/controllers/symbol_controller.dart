import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
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
    ever(favoriteSymbols, watchFavoriteSymbols);
  }

  @override
  void onReady() {
    super.onReady();
    favoriteSymbols.value = SpUtil.getStringList('favoriteSymbols', defValue: []) ?? [];
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getSymbols(exchangeId: _exchangeId, update: true);
  }

  void watchFavoriteSymbols(List<String> _symbols) {
    SpUtil.putStringList('favoriteSymbols', _symbols);
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
        Get.snackbar(
          'Common.Text.Tips'.tr,
          'Common.Text.Dislike'.tr + '[$symbol]',
          duration: Duration(milliseconds: 2000),
          backgroundColor: Colors.red.withOpacity(.2),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        favoriteSymbols.add(symbol);
        Get.snackbar(
          'Common.Text.Tips'.tr,
          'Common.Text.Like'.tr + '[$symbol]',
          duration: Duration(milliseconds: 2000),
          backgroundColor: Colors.green.withOpacity(.2),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void onChangeCurrentSymbol(String _symbol) {
    currentSymbol.value = _symbol.replaceAll('/', '_');
  }
}