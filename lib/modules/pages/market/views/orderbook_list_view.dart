import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class OrderBookListView extends GetView<MarketViewController> {
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        // separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => Container(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
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
                              children: [
                                Text(
                                  marketController.formatAmountByPrecision(
                                    controller.orderBook.value.bids[index].last,
                                    controller.market.value.symbol,
                                  ),
                                  // '${(controller.orderBook.value.bids[index].last).toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).textTheme.bodyText1?.color,
                                      ),
                                ),
                                Text(
                                  marketController.formatPriceByPrecision(
                                    controller.orderBook.value.bids[index].first,
                                    controller.market.value.symbol,
                                  ),
                                  // '${(controller.orderBook.value.bids[index].first).toStringAsFixed(controller.market.value.precision.price.toInt())}',
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
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  marketController.formatPriceByPrecision(
                                    controller.orderBook.value.asks[index].first,
                                    controller.market.value.symbol,
                                  ),
                                  // '${(controller.orderBook.value.asks[index].first).toStringAsFixed(controller.market.value.precision.price.toInt())}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: settingsController.advanceDeclineColors.last,
                                      ),
                                ),
                                Text(
                                  marketController.formatAmountByPrecision(
                                    controller.orderBook.value.asks[index].last,
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
        itemCount: controller.orderBook.value.bids.length,
        physics: ClampingScrollPhysics(),
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
          children: [
            SizedBox(
              width: 28,
              child: Text(
                'MarketPage.ListViewHeader.Buy'.tr,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            Text(
              'MarketPage.ListViewHeader.Amount'.tr + '(${controller.market.value.base})',
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            ),
            Expanded(
              child: Center(
                  child: Text(
                'MarketPage.ListViewHeader.Price'.tr + '(${controller.market.value.quote})',
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              )),
            ),
            Text(
              'MarketPage.ListViewHeader.Amount'.tr + '(${controller.market.value.base})',
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
