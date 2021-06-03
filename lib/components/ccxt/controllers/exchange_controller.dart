import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:get/get.dart';

class ExchangeController extends GetxController {
  final exchanges = <String>[].obs;
  final currentExchangeId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getExchanges(update: true);
    ever(currentExchangeId, watchCurrentExchangeId);
    updateCurrentExchangeId(SpUtil.getString('currentExchangeId') ?? '');
  }

  void watchCurrentExchangeId(String exchangeId) async {
    if (exchangeId.isEmpty) {
      Get.toNamed('/exchanges');
    } else {
      if (Get.currentRoute != '/') Get.back();

      Get.snackbar(
        'Common.Text.Tips'.tr,
        'Common.Text.SwitchExchangeId'.tr + '[$exchangeId]',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(.2),
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<List<String>> getExchanges({bool? update}) async {
    final result = await ApiCcxt.exchanges();
    if (!result.success) return [];

    final data = List<String>.from(result.data!);
    if (update == true) exchanges.value = data;
    return data;
  }

  void updateCurrentExchangeId(String exchangeId) async {
    if (exchanges.contains(exchangeId)) {
      currentExchangeId.value = exchangeId;
      SpUtil.putString('currentExchangeId', exchangeId);
    } else {
      currentExchangeId.value = '';
    }
  }
}
