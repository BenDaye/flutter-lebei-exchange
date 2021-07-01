import 'package:get/get.dart';

import '../controllers/balances_controller.dart';

class BalancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalancesViewController>(() => BalancesViewController(), fenix: true);
  }
}
