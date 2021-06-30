import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_popular_controller.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

class SymbolPopularGridView extends StatelessWidget {
  final TickerController tickerController = Get.find<TickerController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => settingsController.connectivityResult.value == ConnectivityResult.none
          ? Container()
          : Container(
              margin: const EdgeInsets.only(bottom: 4.0),
              padding: const EdgeInsets.only(bottom: 8.0),
              color: Theme.of(context).backgroundColor,
              child: tickerController.loading.isTrue
                  ? SymbolPopularGridViewShimmer()
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        SymbolPopularGridViewContent(),
                        SymbolPopularGridViewIndicator(),
                      ],
                    ),
            ),
    );
  }
}

class SymbolPopularGridViewContent extends GetView<SymbolPopularGridViewController> {
  final SymbolController symbolController = Get.find<SymbolController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
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
                    .map((Ticker? ticker) => ticker == null ? Container() : SymbolPopularGridItem(ticker: ticker))
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
    );
  }
}

class SymbolPopularGridItem extends StatelessWidget {
  SymbolPopularGridItem({required this.ticker});
  final Ticker ticker;

  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
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
    );
  }
}

class SymbolPopularGridViewIndicator extends GetView<SymbolPopularGridViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
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
      ),
    );
  }
}

class SymbolPopularGridViewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: List<num>.filled(3, 0)
              .map<Widget>(
                (num e) => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).dividerColor,
                        highlightColor: Theme.of(context).highlightColor,
                        child: Container(
                          color: Colors.white,
                          width: 96,
                          height: 19,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).dividerColor,
                        highlightColor: Theme.of(context).highlightColor,
                        child: Container(
                          color: Colors.white,
                          width: 80,
                          height: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).dividerColor,
                        highlightColor: Theme.of(context).highlightColor,
                        child: Container(
                          color: Colors.white,
                          width: 72,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
