import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/symbol_helper.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
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
                    '${controller.ticker.value.bid}',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: SymbolHelper.getPercentageColor(
                              settingsController.advanceDeclineColors, controller.ticker.value.percentage),
                        ),
                  )),
                  Text(
                    '${SymbolHelper.getPercentageSymbol(controller.ticker.value.percentage)}${controller.ticker.value.percentage?.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: SymbolHelper.getPercentageColor(
                          settingsController.advanceDeclineColors, controller.ticker.value.percentage),
                    ),
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
                      Text('高'),
                      SizedBox(width: 8),
                      Text('${controller.ticker.value.high?.toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('低'),
                      SizedBox(width: 8),
                      Text('${controller.ticker.value.low?.toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('24H'),
                      SizedBox(width: 8),
                      Text('${controller.ticker.value.baseVolume?.toStringAsFixed(0)}'),
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
