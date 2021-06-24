import 'package:flutter_lebei_exchange/modules/pages/trade/controllers/trades_controller.dart';
import 'package:get/get.dart';

class TradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradesViewController>(() => TradesViewController(), fenix: true);
  }
}
