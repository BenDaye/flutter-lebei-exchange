import 'package:get/get.dart';

import '../controllers/trades_controller.dart';

class TradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradesViewController>(() => TradesViewController(), fenix: true);
  }
}
