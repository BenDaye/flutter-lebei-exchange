import 'package:flutter_lebei_exchange/modules/pages/home/controllers/banner_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/notice_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_popular_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topbasevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_toppercentage_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topquotevolume_list_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewController>(HomeViewController(), permanent: true);

    Get.lazyPut<HomeBannerController>(() => HomeBannerController());
    Get.lazyPut<HomeNoticeController>(() => HomeNoticeController());

    Get.lazyPut<SymbolPopularGridViewController>(() => SymbolPopularGridViewController());

    Get.lazyPut<SymbolTopPercentageListController>(() => SymbolTopPercentageListController());
    Get.lazyPut<SymbolTopBaseVolumeListController>(() => SymbolTopBaseVolumeListController());
    Get.lazyPut<SymbolTopQuoteVolumeListController>(() => SymbolTopQuoteVolumeListController());
  }
}
