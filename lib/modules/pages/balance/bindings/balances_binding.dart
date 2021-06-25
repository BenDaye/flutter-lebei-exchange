import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/pages/balance/controllers/balances_controller.dart';

class BalancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalancesViewController>(() => BalancesViewController(), fenix: true);
  }
}
