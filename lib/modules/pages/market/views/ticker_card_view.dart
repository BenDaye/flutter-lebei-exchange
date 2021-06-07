import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class TickerCardView extends GetView<MarketViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();
  final MarketController marketController = Get.find<MarketController>();
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
                    marketController.formatPriceByPrecision(
                      TickerHelper.getValuablePrice(controller.ticker.value),
                      controller.ticker.value.symbol,
                    ),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: PercentageHelper.getPercentageColor(
                            settingsController.advanceDeclineColors,
                            controller.ticker.value.percentage,
                          ),
                        ),
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        TickerHelper(
                          ticker: controller.ticker.value,
                          currency: settingsController.currency.value,
                          currencyRate: settingsController.currencyRate.value,
                        ).formatPriceByRate(),
                        maxLines: 1,
                      ),
                      SizedBox(width: 8.0),
                      PercentageHelper.getPercentageText(
                        settingsController.advanceDeclineColors,
                        controller.ticker.value.percentage,
                      ),
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
                        marketController.formatPriceByPrecision(
                          controller.ticker.value.high,
                          controller.ticker.value.symbol,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MarketPage.TickerCard.Low'.tr),
                      SizedBox(width: 8),
                      Text(
                        marketController.formatPriceByPrecision(
                          controller.ticker.value.low,
                          controller.ticker.value.symbol,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MarketPage.TickerCard.24HVol'.tr),
                      SizedBox(width: 8),
                      Text(TickerHelper.getVolumeAsFixed(controller.ticker.value.baseVolume)),
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
