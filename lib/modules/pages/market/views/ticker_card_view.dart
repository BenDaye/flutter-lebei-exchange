import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number_helper.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_view_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class TickerCardView extends GetView<MarketViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    '${(controller.ticker.value.bid ?? 0).toStringAsFixed(controller.market.value.precision.price.toInt())}',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: CcxtHelper.getPercentageColor(
                              settingsController.advanceDeclineColors, controller.ticker.value.percentage),
                        ),
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${NumberHelper.getCurrencySymbol(settingsController.currency.value)} ${NumUtil.multiply((controller.ticker.value.bid ?? 0), settingsController.currencyRate.value).toStringAsFixed(2)}',
                        maxLines: 1,
                      ),
                      SizedBox(width: 8.0),
                      CcxtHelper.getPercentageText(
                          settingsController.advanceDeclineColors, controller.ticker.value.percentage),
                    ],
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MarketPage.TickerCard.High'.tr),
                      SizedBox(width: 8),
                      Text(
                          '${(controller.ticker.value.high ?? 0).toStringAsFixed(controller.market.value.precision.price.toInt())}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MarketPage.TickerCard.Low'.tr),
                      SizedBox(width: 8),
                      Text(
                          '${(controller.ticker.value.low ?? 0).toStringAsFixed(controller.market.value.precision.price.toInt())}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MarketPage.TickerCard.24HVol'.tr),
                      SizedBox(width: 8),
                      Text('${(controller.ticker.value.baseVolume ?? 0).toStringAsFixed(0)}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
