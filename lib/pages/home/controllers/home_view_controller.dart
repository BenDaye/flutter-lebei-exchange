import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin {
  List<String> tabStrings = [
    'RankingList.Hot',
    'RankingList.BaseVol',
    'RankingList.QuoteVol',
    'RankingList.Newest',
  ].obs;

  late TabController tabController;

  final innerScrollPositionKey = Key('innerScrollPositionKey').obs;

  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabStrings.length, vsync: this);
    tabController.addListener(tabControllerListener);
  }

  @override
  void onReady() {
    super.onReady();
    innerScrollPositionKey.value = Key(tabStrings.first);
  }

  @override
  void onClose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    super.onClose();
  }

  void tabControllerListener() {
    innerScrollPositionKey.value = Key(tabStrings[tabController.index]);
  }
}
