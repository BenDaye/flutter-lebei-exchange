import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxBool _isLogoShown = false.obs;
  bool get isLogoShown => _isLogoShown.value;
  set isLogoShown(bool v) => _isLogoShown.value = v;

  final RxBool _isFirstTime = true.obs;
  bool get isFirstTime => _isFirstTime.value;
  set isFirstTime(bool v) => _isFirstTime.value = v;

  @override
  void onInit() {
    isFirstTime = SpUtil.getBool('Splash.isFirstTime', defValue: true) ?? true;
    super.onInit();
    once(_isLogoShown, watchLogoShown);
    Future<void>.delayed(const Duration(milliseconds: 3500), () {
      isLogoShown = true;
    });
  }

  void watchLogoShown(bool _) {
    if (isFirstTime) {
      showIntro();
    } else {
      Get.offAllNamed('/home');
    }
  }

  void showIntro() {
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: const <Widget>[
            CloseButton(),
          ],
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              SpUtil.putBool('Splash.isFirstTime', false);
              isFirstTime = false;
              watchLogoShown(true);
            },
            child: Text('Intro'.tr),
          ),
        ),
      ),
      useSafeArea: false,
    );
  }
}
