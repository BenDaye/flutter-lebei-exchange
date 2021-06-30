import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin {
  final SettingsController settingsController = Get.find<SettingsController>();
  final TickerController tickerController = Get.find<TickerController>();

  final RxList<String> tabStrings = <String>[
    'RankingList.Hot',
    'RankingList.BaseVol',
    'RankingList.QuoteVol',
    'RankingList.Newest',
  ].obs;

  late TabController tabController;

  final Rx<Key> innerScrollPositionKey = const Key('innerScrollPositionKey').obs;

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

  Future<bool> refreshPageData() async {
    await tickerController.getTickersAndUpdate();
    return true;
  }
}
