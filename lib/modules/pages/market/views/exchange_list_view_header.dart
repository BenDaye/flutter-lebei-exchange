import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/exchange_list_view_controller.dart';
import 'package:get/get.dart';

class ExchangeListViewHeader extends GetView<ExchangeListViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            InkWell(
              child: Row(
                children: [
                  Text(
                    'MarketPage.ListViewHeader.Exchange'.tr,
                    style:
                        Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
                  ),
                  controller.sortType.value == SortType.NameDesc
                      ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : controller.sortType.value == SortType.NameAsc
                          ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                          : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
                ],
              ),
              onTap: () {
                if (controller.sortType.value == SortType.NameDesc) {
                  controller.sortType.value = SortType.NameAsc;
                } else {
                  controller.sortType.value = SortType.NameDesc;
                }
              },
            ),
            InkWell(
              child: Row(
                children: [
                  Text(
                    'MarketPage.ListViewHeader.Price'.tr,
                    style:
                        Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
                  ),
                  controller.sortType.value == SortType.PriceDesc
                      ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : controller.sortType.value == SortType.PriceAsc
                          ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                          : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
                ],
              ),
              onTap: () {
                if (controller.sortType.value == SortType.PriceDesc) {
                  controller.sortType.value = SortType.PriceAsc;
                } else {
                  controller.sortType.value = SortType.PriceDesc;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
