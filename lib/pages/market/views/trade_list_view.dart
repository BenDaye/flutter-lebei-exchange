import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class TradeListView extends GetView<MarketViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        // separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateUtil.formatDateMs(controller.trades[index].timestamp!, format: 'HH:mm:ss')}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '${controller.trades[index].side}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: controller.trades[index].side == 'buy'
                          ? settingsController.advanceDeclineColors.first
                          : settingsController.advanceDeclineColors.last),
                ),
                Text(
                  '${controller.trades[index].price}',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                ),
                Text(
                  '${controller.trades[index].amount}',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                ),
              ],
            ),
          ),
        ),
        itemCount: controller.trades.length,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
