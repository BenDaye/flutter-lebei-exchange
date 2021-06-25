import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
