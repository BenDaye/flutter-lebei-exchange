import 'package:get/get.dart';

import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../controllers/exchanges_controller.dart';

class ExchangesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<ExchangeViewController>(() => ExchangeViewController());
  }
}
