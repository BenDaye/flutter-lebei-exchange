import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/exchange_list_view_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExchangeListView extends GetView<ExchangeListViewController> {
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        header: WaterDropMaterialHeader(),
        controller: controller.refreshController,
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: controller.onRefreshExchange,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(indent: 16, height: 1.0),
          itemBuilder: (BuildContext context, int index) => ListTile(
            dense: true,
            title: Text(ExchangeController.getExchangeName(controller.exchanges[index].exchangeId)),
            trailing: Text(
              controller.exchanges[index].price,
              textAlign: TextAlign.right,
            ),
          ),
          itemCount: controller.exchanges.length,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}
