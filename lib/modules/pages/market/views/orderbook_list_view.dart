import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/ccxt/market.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/views/orderbook_list_tile.dart';
import '../../../commons/settings/controller/settings_controller.dart';
import '../controllers/orderbook_list_controller.dart';

class OrderBookListView extends StatelessWidget {
  OrderBookListView(this.symbol);
  final String symbol;
  final OrderBookListController orderBookListController = Get.put(OrderBookListController(), tag: 'MarketPage');
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
          itemBuilder: (BuildContext context, int index) => OrderBookListTile(
            index: index,
            bidAmount: orderBookListController.bids[index][1],
            bidPrice: orderBookListController.bids[index].first,
            bidAmountPercentage: orderBookListController.bids[index].last,
            askAmount: orderBookListController.asks[index][1],
            askPrice: orderBookListController.asks[index].first,
            askAmountPercentage: orderBookListController.asks[index].last,
            symbol: symbol,
          ),
          itemCount: orderBookListController.bids.length,
          // physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class OrderBookListViewHeader extends StatelessWidget {
  const OrderBookListViewHeader(this.market, {this.color});
  final Market market;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: color ?? Theme.of(context).backgroundColor,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Text(
              'MarketPage.ListViewHeader.Buy'.tr,
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            ),
          ),
          Text(
            '${'MarketPage.ListViewHeader.Amount'.tr}${'(${market.base})'}',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          Expanded(
            child: Center(
                child: Text(
              '${'MarketPage.ListViewHeader.Price'.tr}${'(${market.quote})'}',
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            )),
          ),
          Text(
            '${'MarketPage.ListViewHeader.Amount'.tr}${'(${market.base})'}',
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
    );
  }
}
