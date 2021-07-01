import 'package:get/get.dart';

import '../controllers/chart_controller.dart';
import '../controllers/exchange_list_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/panel_controller.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChartController>(ChartController(), tag: 'MarketPageChart');

    Get.put<MarketViewController>(MarketViewController());

    Get.lazyPut<MarketPanelController>(() => MarketPanelController());
    Get.lazyPut<ExchangeListViewController>(() => ExchangeListViewController());
  }
}
