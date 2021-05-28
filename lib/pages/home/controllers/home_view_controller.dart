import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin {
  final TickerController tickerController = Get.find<TickerController>();

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

  Future<bool> refreshPageData() async {
    // return await Future.delayed(Duration(seconds: 3), () => true);
    await tickerController.getTickers(update: true);
    return true;
  }
}
