import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/pages/main/controllers/main_controller.dart';

class MainView extends GetView<MainViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: controller.currentIndex.value,
          onItemSelected: controller.setCurrentIndex,
          items: controller.bottomNavyBarItems(context),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
