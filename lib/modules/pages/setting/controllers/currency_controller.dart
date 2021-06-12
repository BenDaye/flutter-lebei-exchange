import 'package:flutter_lebei_exchange/api/juhe.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/juhe/exchange.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:get/get.dart';

class CurrencyViewController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();

  final RxList<Code> codes = <Code>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    codes.value = await getCurrencies();
  }

  Future<List<Code>> getCurrencies() async {
    final HttpResult<List<dynamic>> result = await ApiJuhe.exchangeList();
    if (!result.success) return <Code>[];
    final List<Code> _codes =
        List<Code>.from(result.data!.map((dynamic e) => Code.fromJson(e as Map<String, dynamic>)));
    return _codes;
  }
}
