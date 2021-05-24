import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/exchange_controller.dart';
import 'package:get/get.dart';

class ExchangesView extends GetView<ExchangeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易所列表'),
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Obx(() => Text('${controller.exchanges[index]}')),
            selected: controller.currentExchangeId.value == controller.exchanges[index],
            onTap: () => controller.updateCurrentExchangeId(controller.exchanges[index]),
          ),
          itemCount: controller.exchanges.length,
        ),
      ),
    );
  }
}
