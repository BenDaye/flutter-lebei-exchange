import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_view_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
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
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    '${DateUtil.formatDateMs(controller.trades[index].timestamp!, format: 'HH:mm:ss')}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.trades[index].side == 'buy'
                        ? 'MarketPage.ListView.Buy'.tr
                        : 'MarketPage.ListView.Sell'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: controller.trades[index].side == 'buy'
                            ? settingsController.advanceDeclineColors.first
                            : settingsController.advanceDeclineColors.last),
                  ),
                ),
                SizedBox(
                  width: Get.width / 3,
                  child: Text(
                    '${(controller.trades[index].price).toStringAsFixed(controller.market.value.precision.price.toInt())}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                  ),
                ),
                SizedBox(
                  width: Get.width / 3,
                  child: Text(
                    '${(controller.trades[index].amount).toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
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