import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_view_controller.dart';
import 'package:get/get.dart';

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
