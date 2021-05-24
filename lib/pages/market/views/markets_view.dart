import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/markets_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarketsView extends GetView<MarketsViewController> {
  final SymbolController symbolController = Get.find<SymbolController>();
  final TickerController tickerController = Get.find<TickerController>();

  @override
  Widget build(BuildContext context) {
    TextStyle? categoryTextStyle(bool actived) => actived
        ? Theme.of(context).primaryTextTheme.headline6?.copyWith(
              color: Theme.of(context).accentColor,
            )
        : Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
              color: Theme.of(context).textTheme.caption?.color,
            );
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: ToggleButtons(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => Text(
                  '自选',
                  style: categoryTextStyle(controller.selectedCategories[0]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => Text(
                  '币币',
                  style: categoryTextStyle(controller.selectedCategories[1]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => Text(
                  '杠杆',
                  style: categoryTextStyle(controller.selectedCategories[2]),
                ),
              ),
            ),
          ],
          isSelected: controller.selectedCategories,
          renderBorder: false,
          fillColor: Colors.transparent,
          onPressed: controller.onChangeCategory,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
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
