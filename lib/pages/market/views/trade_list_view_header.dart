import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:get/get.dart';

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
          children: [
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
                'MarketPage.ListViewHeader.Price'.tr + '(${controller.market.value.quote})',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            SizedBox(
              width: Get.width / 3,
              child: Text(
                'MarketPage.ListViewHeader.Amount'.tr + '(${controller.market.value.base})',
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
