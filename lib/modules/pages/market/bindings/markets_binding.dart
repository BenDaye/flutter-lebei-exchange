import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';
import 'package:get/get.dart';

class MarketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketsViewController>(() => MarketsViewController(), fenix: true);
  }
}
