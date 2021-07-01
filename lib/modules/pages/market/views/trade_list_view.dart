import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/settings/controller/settings_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/trade_list_controller.dart';

class TradeListView extends GetView<MarketViewController> {
  final TradeListController tradeListController = Get.put(TradeListController());
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        controller: tradeListController.refreshController,
        header: const WaterDropMaterialHeader(),
        onRefresh: () async {
          await tradeListController.getTradesAnUpdate();
          tradeListController.refreshController.refreshCompleted();
        },
        child: ListView.builder(
          // separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
          itemBuilder: (BuildContext context, int index) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      DateUtil.formatDateMs(tradeListController.data[index].timestamp!, format: 'HH:mm:ss'),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tradeListController.data[index].side == 'buy'
                          ? 'MarketPage.ListView.Buy'.tr
                          : 'MarketPage.ListView.Sell'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: tradeListController.data[index].side == 'buy'
                              ? settingsController.advanceDeclineColors.first
                              : settingsController.advanceDeclineColors.last),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3,
                    child: Text(
                      marketController.formatPriceByPrecision(
                        tradeListController.data[index].price,
                        controller.market.value.symbol,
                      ),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3,
                    child: Text(
                      marketController.formatAmountByPrecision(
                        tradeListController.data[index].amount,
                        controller.market.value.symbol,
                      ),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: tradeListController.data.length,
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class TradeListViewHeader extends GetView<MarketViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Theme.of(context).backgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            SizedBox(
              width: 80,
              child: Text(
                'MarketPage.ListViewHeader.Time'.tr,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            Expanded(
              child: Text(
                'MarketPage.ListViewHeader.Type'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            SizedBox(
              width: Get.width / 3,
              child: Text(
                '${'MarketPage.ListViewHeader.Price'.tr}${'(${controller.market.value.quote})'}',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            SizedBox(
              width: Get.width / 3,
              child: Text(
                '${'MarketPage.ListViewHeader.Amount'.tr}${'(${controller.market.value.base})'}',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
