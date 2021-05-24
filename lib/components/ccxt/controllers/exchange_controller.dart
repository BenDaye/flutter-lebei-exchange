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
    await this.getExchanges(update: true);
    ever(currentExchangeId, watchCurrentExchangeId);
    this.updateCurrentExchangeId(SpUtil.getString('currentExchangeId') ?? '');
  }

  void watchCurrentExchangeId(String exchangeId) async {
    if (exchangeId.isEmpty) {
      Get.toNamed('/exchanges');
    } else {
      Get.back();
      Get.showSnackbar(GetBar(
        messageText: Text('已切换至[$exchangeId]'),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
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
