import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_popular_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class SymbolPopularGridView extends StatelessWidget {
  final SymbolPopularGridViewController controller =
      Get.put<SymbolPopularGridViewController>(SymbolPopularGridViewController());
  final TickerController tickerController = Get.find<TickerController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  List<List<T>> computeList<T>(List<T> l) {
    int _length = int.parse((l.length / 3).toStringAsFixed(0));
    Map<int, List<T>> _l = {};
    for (var i = 0; i < _length; i++) {
      int _endIndex = (i + 1) * 3 > l.length ? l.length : (i + 1) * 3;
      _l[i] = l.sublist(i * 3, _endIndex);
    }
    return _l.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () {
          final splitedList = computeList<Ticker>(
            tickerController.tickers
                .where((t) =>
                    t.symbol.startsWith(RegExp(r"BTC|ETH|XCH|DOT|SHIB|DOGE")) &&
                    t.symbol.endsWith('USDT') &&
                    !RegExp(r"[1-9]\d*[LS]").hasMatch(t.symbol))
                .take(6)
                .toList(),
          );
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 80.0,
                child: CarouselSlider.builder(
                  itemCount: splitedList.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final tickers = List<Ticker?>.filled(3, null)
                      ..setRange(0, splitedList[index].length, splitedList[index]);
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
                                              '${ticker.bid ?? 0}',
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
                                              '${MoneyUtil.YUAN} ${NumUtil.multiply((ticker.bid ?? 0), 7).toStringAsFixed(2)}',
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
                children: splitedList
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
