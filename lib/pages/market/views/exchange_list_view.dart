import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/exchange_list_view_controller.dart';
import 'package:get/get.dart';

class ExchangeListView extends GetView<ExchangeListViewController> {
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(indent: 16, height: 1.0),
        itemBuilder: (BuildContext context, int index) => ListTile(
          dense: true,
          title: Text(controller.exchanges[index].exchangeId),
          trailing: Text(
            controller.exchanges[index].price,
            textAlign: TextAlign.right,
          ),
        ),
        itemCount: controller.exchanges.length,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
