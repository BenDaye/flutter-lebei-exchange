import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';

class ExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
  }
}
