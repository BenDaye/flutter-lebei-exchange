import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/models/ccxt/currency.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

class CurrencyController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();

  final currencies = <Currency>[].obs;
  final currenciesMap = <String, Currency>{}.obs;

  @override
  void onInit() {
    super.onInit();
    ever(exchangeController.currentExchangeId, watchCurrentExchangeId);
    ever(currenciesMap, watchCurrenciesMap);
  }

  void watchCurrentExchangeId(String _exchangeId) {
    getCurrenciesAndUpdate();
  }

  void watchCurrenciesMap(Map<String, Currency> _currenciesMap) {
    currencies.value = _currenciesMap.values.toList();
  }

  void getCurrenciesAndUpdate() async {
    final _currenciesMap = await getCurrenciesMap();
    if (_currenciesMap == null) return;
    currenciesMap.value = _currenciesMap;
  }

  Future<Map<String, Currency>?> getCurrenciesMap({String? exchangeId}) async {
    String _exchangeId = exchangeId ?? exchangeController.currentExchangeId.value;
    if (_exchangeId.isEmpty) return null;

    final result = await ApiCcxt.currencies(_exchangeId);
    if (!result.success) return null;

    try {
      return result.data!.map<String, Currency>(
        (key, value) => MapEntry(key, Currency.fromJson(value)),
      );
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
