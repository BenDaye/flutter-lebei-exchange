import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin {
  List<Tab> tabs = [
    'RankingList.Hot',
    'RankingList.BaseVol',
    'RankingList.QuoteVol',
    'RankingList.Newest',
  ]
      .map(
        (t) => Tab(
          text: t.tr,
          key: Key(t),
        ),
      )
      .toList()
      .obs;

  List<String> tabStrings = [
    'RankingList.Hot',
    'RankingList.BaseVol',
    'RankingList.QuoteVol',
    'RankingList.Newest',
  ].obs;

  late TabController tabController;

  final innerScrollPositionKey = Key('RankingList.Hot').obs;

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
