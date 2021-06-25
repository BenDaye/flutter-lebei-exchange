import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/exchange/controllers/exchanges_controller.dart';

class ExchangesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<ExchangeViewController>(() => ExchangeViewController());
  }
}
