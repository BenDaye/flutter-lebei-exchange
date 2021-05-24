import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:get/get.dart';

class OrderBookListViewHeader extends GetView<MarketViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '买盘',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          SizedBox(width: 4),
          Text(
            '数量(${controller.market.value.base})',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          Expanded(
            child: Center(
                child: Text(
              '价格(${controller.market.value.quote})',
              style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
            )),
          ),
          Text(
            '数量(${controller.market.value.base})',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
          SizedBox(width: 4),
          Text(
            '卖盘',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).unselectedWidgetColor),
          ),
        ],
      ),
    );
  }
}
