import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/trade/controllers/trades_controller.dart';

class TradesView extends GetView<TradesViewController> {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            ExchangeController.getExchangeName(exchangeController.currentExchangeId.value),
            style: Theme.of(context).textTheme.headline6,
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: controller.showInfoDialog,
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        // body: ListView(
        //   children: <Widget>[],
        // ),
      ),
    );
  }
}
