import 'package:flutter_lebei_exchange/api/juhe.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/juhe/exchange.dart';
import 'package:get/get.dart';

class CurrencyViewController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();

  final codes = <Code>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getCurrencies();
  }

  Future _getCurrencies() async {
    codes.value = await getCurrencies();
  }

  Future<List<Code>> getCurrencies() async {
    final result = await ApiJuhe.exchangeList();
    if (!result.success) return [];
    List<Code> _codes = List<Code>.from(result.data!.map((e) => Code.fromJson(e)));
    return _codes;
  }
}
