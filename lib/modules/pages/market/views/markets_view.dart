import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/category_title_view.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Get.toNamed('/search_symbol'),
          ),
        ],
      ),
      body: Obx(
        () => PageView(
          controller: controller.selectedCategoryPageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                MarketsListViewHeader(),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      Ticker? ticker = tickerController.tickers
                          .firstWhere((t) => t.symbol == symbolController.favoriteSymbols[index]);
                      return TickerPercentageListTile(ticker);
                    },
                    itemCount: symbolController.favoriteSymbols.length,
                  ),
                ),
              ],
            ),
            Column(
              children: [
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
                  child: SmartRefresher(
                    header: WaterDropMaterialHeader(),
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      await tickerController.getTickers();
                      controller.refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
                      itemBuilder: (BuildContext context, int index) =>
                          TickerPercentageListTile(controller.tickers[index]),
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
            if (controller.sortType.value == SortType.SymbolDesc) {
              controller.sortType.value = SortType.SymbolAsc;
            } else if (controller.sortType.value == SortType.SymbolAsc) {
              controller.sortType.value = SortType.UnSet;
            } else {
              controller.sortType.value = SortType.SymbolDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ListViewHeader.Symbol'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              controller.sortType.value == SortType.SymbolDesc
                  ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  : controller.sortType.value == SortType.SymbolAsc
                      ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
        middle: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.PriceDesc) {
              controller.sortType.value = SortType.PriceAsc;
            } else if (controller.sortType.value == SortType.PriceAsc) {
              controller.sortType.value = SortType.UnSet;
            } else {
              controller.sortType.value = SortType.PriceDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ListViewHeader.LastPrice'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              controller.sortType.value == SortType.PriceDesc
                  ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  : controller.sortType.value == SortType.PriceAsc
                      ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
        last: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.PercentageDesc) {
              controller.sortType.value = SortType.PercentageAsc;
            } else if (controller.sortType.value == SortType.PercentageAsc) {
              controller.sortType.value = SortType.UnSet;
            } else {
              controller.sortType.value = SortType.PercentageDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ListViewHeader.Change%'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              controller.sortType.value == SortType.PercentageDesc
                  ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  : controller.sortType.value == SortType.PercentageAsc
                      ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
      ),
    );
  }
}
