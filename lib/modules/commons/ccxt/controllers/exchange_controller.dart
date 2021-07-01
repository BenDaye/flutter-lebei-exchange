import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry/sentry.dart';

import '../../../../api/ccxt.dart';
import '../../../../models/ccxt/exchange.dart';
import '../../../../utils/http/handler/types.dart';
import '../helpers/local.dart';

class ExchangeController extends GetxController {
  final RxList<String> exchanges = <String>[].obs;
  final RxString currentExchangeId = ''.obs;
  final Rx<Exchange> currentExchange = Exchange.empty().obs;

  final RxList<String> timeframes = <String>[].obs;

  late Worker exchangeIdWorker;
  late Worker exchangeWorker;

  @override
  void onInit() {
    super.onInit();
    exchangeIdWorker = ever(currentExchangeId, watchCurrentExchangeId);
    exchangeWorker = ever(currentExchange, watchCurrentExchange);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getExchangesAndUpdate();
    updateCurrentExchangeId(SpUtil.getString('Exchange.currentExchangeId') ?? '');
  }

  @override
  void onClose() {
    exchangeIdWorker.dispose();
    exchangeWorker.dispose();
    super.onClose();
  }

  void watchCurrentExchangeId(String exchangeId) {
    if (exchangeId.isEmpty) {
      currentExchange.value = Exchange.empty();
      // ignore: always_specify_types
      Get.offNamedUntil('/exchanges', (route) => route.isFirst);
      return;
    }

    if (Get.currentRoute == '/exchanges') {
      // ignore: always_specify_types
      Get.until((route) => route.isFirst);
    }

    if (!Get.isSnackbarOpen!) {
      Get.snackbar(
        'Common.Text.Tips'.tr,
        '${'Common.Text.SwitchExchangeId'.tr}${'[$exchangeId]'}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(.2),
        duration: const Duration(milliseconds: 2000),
      );
    }

    getExchangeAndUpdate();
  }

  void watchCurrentExchange(Exchange _exchange) {
    timeframes.value = _exchange.timeframes?.keys.toList() ?? <String>[];
  }

  Future<void> getExchangesAndUpdate({bool reload = false}) async {
    if (!reload) {
      final List<String>? _exchangesLocal = await getExchangesLocal();
      if (_exchangesLocal is List<String> && _exchangesLocal.isNotEmpty) {
        exchanges.value = _exchangesLocal;
        return;
      }
    }

    final List<String>? _exchanges = await getExchanges();
    if (_exchanges == null) return;
    exchanges.value = _exchanges;
    if (_exchanges.isNotEmpty) SpUtil.putStringList('Exchange.exchanges', _exchanges);
  }

  Future<List<String>?> getExchangesLocal() async {
    if (SpUtil.haveKey('Exchange.exchanges') == false) return null;
    return SpUtil.getStringList('Exchange.exchanges', defValue: <String>[]);
  }

  Future<List<String>?> getExchanges() async {
    final HttpResult<List<dynamic>> result = await ApiCcxt.exchanges();
    if (!result.success) return null;

    return List<String>.from(result.data!);
  }

  Future<void> updateCurrentExchangeId(String exchangeId) async {
    if (exchanges.contains(exchangeId)) {
      currentExchangeId.value = exchangeId;
      SpUtil.putString('Exchange.currentExchangeId', exchangeId);
      return;
    }
    currentExchangeId.value = '';
  }

  Future<void> getExchangeAndUpdate({String? exchangeId, bool reload = false}) async {
    final String _exchangeId = exchangeId ?? currentExchangeId.value;
    if (_exchangeId.isEmpty) return;

    if (!reload) {
      final Exchange? _exchangeLocal = await getExchangeLocal(_exchangeId);
      if (_exchangeLocal is Exchange) {
        currentExchange.value = _exchangeLocal;
        return;
      }
    }

    final Exchange? _exchange = await getExchange(_exchangeId);
    if (_exchange is Exchange) {
      currentExchange.value = _exchange;
      SpUtil.putObject('Exchange.$_exchangeId', _exchange.toJson());
      return;
    }
  }

  Future<Exchange?> getExchangeLocal(String exchangeId) async {
    try {
      final Map<dynamic, dynamic>? exchangeLocalObject = SpUtil.getObject('Exchange.$exchangeId');
      if (exchangeLocalObject == null) return null;
      final Exchange _exchange = Exchange.fromJson(
        exchangeLocalObject.map(
          (dynamic key, dynamic value) => MapEntry<String, dynamic>(key.toString(), value),
        ),
      );
      return _exchange;
    } catch (err) {
      SpUtil.remove('Exchange.$exchangeId');
      Sentry.captureException(err);
      return null;
    }
  }

  Future<Exchange?> getExchange(String exchangeId) async {
    if (exchangeId.isEmpty) return null;

    final HttpResult<Map<String, dynamic>> result = await ApiCcxt.exchange(exchangeId);
    if (!result.success) return null;

    try {
      return Exchange.fromJson(result.data!);
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  static String getExchangeName(String exchangeId) {
    if (exchangeId.isEmpty) return '';

    final LocalExchangeModel _localExchange = LocalExchange.exchanges.firstWhere(
      (LocalExchangeModel e) => e.id == exchangeId,
      orElse: () => LocalExchangeModel.empty(),
    );

    if (_localExchange.id == LocalExchangeModel.empty().id) {
      return exchangeId;
    }

    return _localExchange.name;
  }
}
