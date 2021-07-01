import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../utils/http/handler/types.dart';
import 'exchange_controller.dart';

class SymbolController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final RxList<String> symbols = <String>[].obs;
  final RxString currentSymbol = ''.obs;

  final RxList<String> favoriteSymbols = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(favoriteSymbols, watchFavoriteSymbols);
  }

  @override
  void onReady() {
    super.onReady();
    favoriteSymbols.value = SpUtil.getStringList('Symbol.favoriteSymbols', defValue: <String>[]) ?? <String>[];
  }

  void watchCurrentExchangeId(String _exchangeId) {
    if (_exchangeId.isEmpty) {
      symbols.clear();
      favoriteSymbols.clear();
      currentSymbol.value = '';
      return;
    }
    getSymbolsAndUpdate();
  }

  void watchFavoriteSymbols(List<String> _symbols) {
    SpUtil.putStringList('Symbol.favoriteSymbols', _symbols);
  }

  Future<void> getSymbolsAndUpdate({String? exchangeId}) async {
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return;

    final List<String>? result = await getSymbols(exchangeId: _exchangeId);
    if (result == null) return;
    symbols.value = result;
  }

  Future<List<String>?> getSymbols({String? exchangeId}) async {
    final String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final HttpResult<List<dynamic>> result = await ApiCcxt.symbols(_exchangeId);
    if (!result.success) return null;

    try {
      return List<String>.from(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  void toggleFavoriteSymbol(String symbol) {
    if (symbols.contains(symbol)) {
      if (favoriteSymbols.contains(symbol)) {
        favoriteSymbols.remove(symbol);
        Get.snackbar(
          'Common.Text.Tips'.tr,
          '${'Common.Text.Dislike'.tr}${'[$symbol]'}',
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.red.withOpacity(.2),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        favoriteSymbols.add(symbol);
        Get.snackbar(
          'Common.Text.Tips'.tr,
          '${'Common.Text.Like'.tr}${'[$symbol]'}',
          duration: const Duration(milliseconds: 2000),
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
