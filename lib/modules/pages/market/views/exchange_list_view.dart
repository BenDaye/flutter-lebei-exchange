import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/exchange_list_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExchangeListView extends GetView<ExchangeListViewController> {
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        header: const WaterDropMaterialHeader(),
        controller: controller.refreshController,
        onRefresh: controller.onRefreshExchange,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(indent: 16, height: 1.0),
          itemBuilder: (BuildContext context, int index) => ListTile(
            dense: true,
            title: Text(ExchangeController.getExchangeName(controller.exchanges[index].exchangeId)),
            trailing: Text(
              controller.exchanges[index].price,
              textAlign: TextAlign.right,
            ),
          ),
          itemCount: controller.exchanges.length,
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

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
          children: <Widget>[
            InkWell(
              onTap: () {
                if (controller.sortType.value == SortType.exchangeDesc) {
                  controller.sortType.value = SortType.exchangeAsc;
                } else {
                  controller.sortType.value = SortType.exchangeDesc;
                }
              },
              child: Row(
                children: <Widget>[
                  Text(
                    'MarketPage.ListViewHeader.Exchange'.tr,
                    style:
                        Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
                  ),
                  if (controller.sortType.value == SortType.exchangeDesc)
                    Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  else
                    controller.sortType.value == SortType.exchangeAsc
                        ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                        : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (controller.sortType.value == SortType.priceDesc) {
                  controller.sortType.value = SortType.priceAsc;
                } else {
                  controller.sortType.value = SortType.priceDesc;
                }
              },
              child: Row(
                children: <Widget>[
                  Text(
                    'MarketPage.ListViewHeader.Price'.tr,
                    style:
                        Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
                  ),
                  if (controller.sortType.value == SortType.priceDesc)
                    Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  else
                    controller.sortType.value == SortType.priceAsc
                        ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                        : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
