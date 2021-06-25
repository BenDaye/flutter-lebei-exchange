import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/orderbook_list_controller.dart';

class OrderBookListView extends GetView<MarketViewController> {
  final OrderBookListController orderBookListController = Get.put(OrderBookListController());
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        controller: orderBookListController.refreshController,
        header: const WaterDropMaterialHeader(),
        onRefresh: () async {
          await orderBookListController.getOrderBookAnUpdate();
          orderBookListController.refreshController.refreshCompleted();
        },
        child: ListView.builder(
          // separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
          itemBuilder: (BuildContext context, int index) => SizedBox(
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${index + 1}',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    marketController.formatAmountByPrecision(
                                      orderBookListController.data.value.bids[index].last,
                                      controller.market.value.symbol,
                                    ),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: Theme.of(context).textTheme.bodyText1?.color,
                                        ),
                                  ),
                                  Text(
                                    marketController.formatPriceByPrecision(
                                      orderBookListController.data.value.bids[index].first,
                                      controller.market.value.symbol,
                                    ),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: settingsController.advanceDeclineColors.first,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    marketController.formatPriceByPrecision(
                                      orderBookListController.data.value.asks[index].first,
                                      controller.market.value.symbol,
                                    ),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: settingsController.advanceDeclineColors.last,
                                        ),
                                  ),
                                  Text(
                                    marketController.formatAmountByPrecision(
                                      orderBookListController.data.value.asks[index].last,
                                      controller.market.value.symbol,
                                    ),
                                    // '${(controller.orderBook.value.asks[index].last).toStringAsFixed(2)}',
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: Theme.of(context).textTheme.bodyText1?.color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${index + 1}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemCount: orderBookListController.data.value.bids.length,
          // physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class OrderBookListViewHeader extends GetView<MarketViewController> {
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
              width: 28,
              child: Text(
                'MarketPage.ListViewHeader.Buy'.tr,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            Text(
              '${'MarketPage.ListViewHeader.Amount'.tr}${'(${controller.market.value.base})'}',
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            ),
            Expanded(
              child: Center(
                  child: Text(
                '${'MarketPage.ListViewHeader.Price'.tr}${'(${controller.market.value.quote})'}',
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              )),
            ),
            Text(
              '${'MarketPage.ListViewHeader.Amount'.tr}${'(${controller.market.value.base})'}',
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            ),
            SizedBox(
              width: 28,
              child: Text(
                'MarketPage.ListViewHeader.Sell'.tr,
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
