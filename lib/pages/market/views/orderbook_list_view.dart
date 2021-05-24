import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class OrderBookListView extends GetView<MarketViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        // separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => Container(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.orderBook.value.bids[index].last}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).textTheme.bodyText1?.color,
                                      ),
                                ),
                                Text(
                                  '${controller.orderBook.value.bids[index].first}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: settingsController.advanceDeclineColors.first,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.orderBook.value.asks[index].first}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: settingsController.advanceDeclineColors.last,
                                      ),
                                ),
                                Text(
                                  '${controller.orderBook.value.asks[index].last}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).textTheme.bodyText1?.color,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 28,
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: controller.orderBook.value.bids.length,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
