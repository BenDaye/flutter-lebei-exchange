import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/number_helper.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_popular_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class SymbolPopularGridView extends StatelessWidget {
  final SymbolPopularGridViewController controller =
      Get.put<SymbolPopularGridViewController>(SymbolPopularGridViewController());
  final TickerController tickerController = Get.find<TickerController>();
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      padding: EdgeInsets.only(bottom: 8.0),
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 80.0,
                child: CarouselSlider.builder(
                  itemCount: controller.tickersForRender.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final tickers = List<Ticker?>.filled(3, null)
                      ..setRange(0, controller.tickersForRender[index].length, controller.tickersForRender[index]);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: tickers
                            .map(
                              (ticker) => Expanded(
                                child: ticker == null
                                    ? Container()
                                    : InkWell(
                                        onTap: () => Get.toNamed('/market/${ticker.symbol.replaceAll('/', '_')}'),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: ticker.symbol,
                                                style: Theme.of(context).textTheme.bodyText2,
                                                children: [
                                                  TextSpan(
                                                    text: '  ${(ticker.percentage ?? 0).toStringAsFixed(2)}%',
                                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                                          color: NumUtil.isZero(ticker.percentage)
                                                              ? settingsController.advanceDeclineColors[1]
                                                              : NumUtil.greaterThan(ticker.percentage!, 0)
                                                                  ? settingsController.advanceDeclineColors.first
                                                                  : settingsController.advanceDeclineColors.last,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '${marketController.formatPriceByPrecision(ticker)}',
                                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                    color: NumUtil.isZero(ticker.percentage)
                                                        ? settingsController.advanceDeclineColors[1]
                                                        : NumUtil.greaterThan(ticker.percentage!, 0)
                                                            ? settingsController.advanceDeclineColors.first
                                                            : settingsController.advanceDeclineColors.last,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              '${NumberHelper.getCurrencySymbol(settingsController.currency.value)} ${NumUtil.multiply((ticker.bid ?? 0), settingsController.currencyRate.value).toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.caption,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 100.0,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    onPageChanged: controller.onChangePageIndex,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.tickersForRender
                    .asMap()
                    .entries
                    .map(
                      (e) => Container(
                        width: 8.0,
                        height: 2.0,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          color: e.key == controller.currentIndex.value
                              ? Theme.of(context).accentColor
                              : Theme.of(context).dividerColor,
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          );
        },
      ),
    );
  }
}
