import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';

class OrderBookListTile extends StatelessWidget {
  OrderBookListTile({
    required this.index,
    required this.bidAmount,
    required this.bidPrice,
    required this.askAmount,
    required this.askPrice,
    required this.symbol,
    this.bidAmountPercentage,
    this.askAmountPercentage,
    this.onBidPriceTap,
    this.onAskPriceTap,
  });
  final int index;
  final double bidAmount;
  final double? bidAmountPercentage;
  final double bidPrice;
  final double askAmount;
  final double? askAmountPercentage;
  final double askPrice;
  final String symbol;
  final Function(double)? onBidPriceTap;
  final Function(double)? onAskPriceTap;

  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: bidAmountPercentage,
                            heightFactor: 1,
                            child: Container(
                              color: settingsController.advanceDeclineColors.first.withOpacity(.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$index',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  marketController.formatAmountByPrecision(bidAmount, symbol),
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).textTheme.bodyText1?.color,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (onBidPriceTap != null) onBidPriceTap!(bidPrice);
                                  },
                                  child: Text(
                                    marketController.formatPriceByPrecision(bidPrice, symbol),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: settingsController.advanceDeclineColors.first,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: askAmountPercentage,
                            heightFactor: 1,
                            child: Container(
                              color: settingsController.advanceDeclineColors.last.withOpacity(.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (onAskPriceTap != null) onAskPriceTap!(askPrice);
                                  },
                                  child: Text(
                                    marketController.formatPriceByPrecision(askPrice, symbol),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                          color: settingsController.advanceDeclineColors.last,
                                        ),
                                  ),
                                ),
                                Text(
                                  marketController.formatAmountByPrecision(askAmount, symbol),
                                  // '${(controller.orderBook.value.asks[index].last).toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).textTheme.bodyText1?.color,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$index',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
