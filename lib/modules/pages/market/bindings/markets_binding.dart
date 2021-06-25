import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';

class MarketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketsViewController>(() => MarketsViewController(), fenix: true);
  }
}
