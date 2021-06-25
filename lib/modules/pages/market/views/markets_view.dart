// import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/category_title_view.dart';

class MarketsView extends GetView<MarketsViewController> {
  final SymbolController symbolController = Get.find<SymbolController>();
  final TickerController tickerController = Get.find<TickerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: CategoryTitleView(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed('/search_symbol'),
          ),
        ],
      ),
      body: Obx(
        () => PageView(
          controller: controller.selectedCategoryPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                MarketsListViewHeader(),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      final Ticker ticker = tickerController.tickers
                          .firstWhere((Ticker t) => t.symbol == symbolController.favoriteSymbols[index]);
                      return TickerPercentageListTile(ticker);
                    },
                    itemCount: symbolController.favoriteSymbols.length,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: .5, color: Theme.of(context).dividerColor),
                      bottom: BorderSide(width: .5, color: Theme.of(context).dividerColor),
                    ),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      tabs: controller.currentCategoryQuotes,
                      controller: controller.currentCategoryQuotesController,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                ),
                MarketsListViewHeader(),
                Expanded(
                  // child: LiveList.options(
                  //   itemBuilder: (
                  //     BuildContext context,
                  //     int index,
                  //     Animation<double> animation,
                  //   ) =>
                  //       FadeTransition(
                  //     opacity: Tween<double>(
                  //       begin: 0,
                  //       end: 1,
                  //     ).animate(animation),
                  //     child: SlideTransition(
                  //       position: Tween<Offset>(
                  //         begin: Offset(0, -0.1),
                  //         end: Offset.zero,
                  //       ).animate(animation),
                  //       child: TickerPercentageListTile(controller.tickers[index]),
                  //     ),
                  //   ),
                  //   itemCount: controller.tickers.length,
                  //   options: LiveOptions(),
                  // ),
                  child: SmartRefresher(
                    header: const WaterDropMaterialHeader(),
                    controller: controller.refreshController,
                    onRefresh: () async {
                      await tickerController.getTickersAndUpdate();
                      controller.refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                      controller: controller.scrollController,
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0),
                      itemBuilder: (BuildContext context, int index) => FocusDetector(
                        onVisibilityGained: () {
                          controller.focusIndexes.insert(0, index);
                        },
                        onVisibilityLost: () {
                          controller.focusIndexes.removeWhere((int e) => e == index);
                        },
                        child: TickerPercentageListTile(controller.tickers[index]),
                      ),
                      itemCount: controller.tickers.length,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MarketsListViewHeader extends GetView<MarketsViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HomeListViewHeader(
        first: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.symbolDesc) {
              controller.sortType.value = SortType.symbolAsc;
            } else if (controller.sortType.value == SortType.symbolAsc) {
              controller.sortType.value = SortType.unset;
            } else {
              controller.sortType.value = SortType.symbolDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ListViewHeader.Symbol'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              if (controller.sortType.value == SortType.symbolDesc)
                Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
              else
                controller.sortType.value == SortType.symbolAsc
                    ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                    : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
        middle: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.priceDesc) {
              controller.sortType.value = SortType.priceAsc;
            } else if (controller.sortType.value == SortType.priceAsc) {
              controller.sortType.value = SortType.unset;
            } else {
              controller.sortType.value = SortType.priceDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ListViewHeader.LastPrice'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              if (controller.sortType.value == SortType.priceDesc)
                Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
              else
                controller.sortType.value == SortType.priceAsc
                    ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                    : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
        last: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.percentageDesc) {
              controller.sortType.value = SortType.percentageAsc;
            } else if (controller.sortType.value == SortType.percentageAsc) {
              controller.sortType.value = SortType.unset;
            } else {
              controller.sortType.value = SortType.percentageDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'ListViewHeader.Change%'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              if (controller.sortType.value == SortType.percentageDesc)
                Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
              else
                controller.sortType.value == SortType.percentageAsc
                    ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                    : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
      ),
    );
  }
}
