import 'package:flutter_lebei_exchange/modules/pages/market/controllers/chart_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/pages/market/controllers/exchange_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/panel_controller.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChartController>(ChartController(), tag: 'MarketPageChart');

    Get.put<MarketViewController>(MarketViewController());

    Get.lazyPut<MarketPanelController>(() => MarketPanelController());
    Get.lazyPut<ExchangeListViewController>(() => ExchangeListViewController());
  }
}
