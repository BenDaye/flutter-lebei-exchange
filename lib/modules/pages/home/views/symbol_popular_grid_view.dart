import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_popular_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';
import 'package:get/get.dart';

class SymbolPopularGridView extends StatelessWidget {
  final SymbolPopularGridViewController controller = Get.put(SymbolPopularGridViewController());
  final SymbolController symbolController = Get.find<SymbolController>();
  final TickerController tickerController = Get.find<TickerController>();
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      padding: const EdgeInsets.only(bottom: 8.0),
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SizedBox(
                height: 80.0,
                child: CarouselSlider.builder(
                  itemCount: controller.tickersForRender.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final List<Ticker?> tickers = List<Ticker?>.filled(3, null)
                      ..setRange(0, controller.tickersForRender[index].length, controller.tickersForRender[index]);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: tickers
                            .map(
                              (Ticker? ticker) => Expanded(
                                child: ticker == null
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          symbolController.onChangeCurrentSymbol(ticker.symbol);
                                          Get.toNamed('/market');
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: ticker.symbol,
                                                style: Theme.of(context).textTheme.bodyText2,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ticker.percentage.isNaN
                                                        ? '  ${NumberFormatter.unknownNumberToString}'
                                                        : '  ${(ticker.percentage).toStringAsFixed(2)}%',
                                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                                          color: PercentageHelper.getPercentageColor(
                                                            settingsController.advanceDeclineColors,
                                                            ticker.percentage,
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              marketController.formatPriceByPrecision(
                                                TickerHelper.getValuablePrice(ticker),
                                                ticker.symbol,
                                              ),
                                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                    color: PercentageHelper.getPercentageColor(
                                                      settingsController.advanceDeclineColors,
                                                      ticker.percentage,
                                                    ),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              TickerHelper(
                                                ticker: ticker,
                                                currency: settingsController.currency.value,
                                                currencyRate: settingsController.currencyRate.value,
                                              ).formatPriceByRate(),
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
                    enableInfiniteScroll: false,
                    onPageChanged: controller.onChangePageIndex,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.tickersForRender
                    .asMap()
                    .entries
                    .map(
                      (MapEntry<int, List<Ticker>> e) => Container(
                        width: 8.0,
                        height: 2.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
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
