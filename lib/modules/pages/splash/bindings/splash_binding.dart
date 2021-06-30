import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/pages/splash/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
