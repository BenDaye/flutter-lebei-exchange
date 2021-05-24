import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:get/get.dart';

class TradeListViewHeader extends GetView<MarketViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '时间',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          Text(
            '方向',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          Text(
            '价格(${controller.market.value.quote})',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          Text(
            '数量(${controller.market.value.base})',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
        ],
      ),
    );
  }
}
