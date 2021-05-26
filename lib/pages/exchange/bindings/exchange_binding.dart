import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/pages/exchange/controllers/exchange_view_controller.dart';
import 'package:get/get.dart';

class ExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
    Get.lazyPut<ExchangeViewController>(() => ExchangeViewController());
  }
}
