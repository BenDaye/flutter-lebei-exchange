import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry/sentry.dart';

import 'package:flutter_lebei_exchange/api/juhe.dart';
import 'package:flutter_lebei_exchange/models/juhe/exchange.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';

class CurrencyViewController extends GetxController {
  final SettingsController settingsController = Get.find<SettingsController>();
  final RefreshController refreshController = RefreshController();

  final RxList<Code> codes = <Code>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrenciesAndUpdate();
  }

  Future<void> getCurrenciesAndUpdate({bool reload = false}) async {
    if (!reload) {
      final List<Code>? _codes = await getCurrenciesLocal();
      if (_codes is List<Code> && _codes.isNotEmpty) {
        codes.value = _codes;
        return;
      }
    }
    final List<Code>? _codes = await getCurrencies();
    if (_codes == null) return;
    codes.value = _codes;
    SpUtil.putObjectList('Settings.currencies', _codes.map<Map<String, dynamic>>((Code e) => e.toJson()).toList());
  }

  Future<List<Code>?> getCurrenciesLocal() async {
    try {
      return SpUtil.getObjList(
        'Settings.currencies',
        (Map<dynamic, dynamic> v) => Code.fromJson(
          v.map<String, dynamic>(
            (dynamic key, dynamic value) => MapEntry<String, dynamic>(
              key.toString(),
              value,
            ),
          ),
        ),
      );
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }

  Future<List<Code>?> getCurrencies() async {
    try {
      final HttpResult<List<dynamic>> result = await ApiJuhe.exchangeList();
      if (!result.success) return null;
      final List<Code> _codes =
          List<Code>.from(result.data!.map((dynamic e) => Code.fromJson(e as Map<String, dynamic>)));
      return _codes;
    } catch (err) {
      Sentry.captureException(err);
      return null;
    }
  }
}
