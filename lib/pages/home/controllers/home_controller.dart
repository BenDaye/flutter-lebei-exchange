import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin {
  List<Tab> tabs = [
    '涨幅榜',
    '成交量榜',
    '成交额榜',
    '新币榜',
  ]
      .map((text) {
        return Tab(
          text: text,
          key: Key(text),
        );
      })
      .toList()
      .obs;
  late TabController tabController;

  final innerScrollPositionKey = Key('涨幅榜').obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(tabControllerListener);
  }

  @override
  void onClose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    super.onClose();
  }

  void tabControllerListener() {
    innerScrollPositionKey.value = tabs[tabController.index].key!;
  }
}
