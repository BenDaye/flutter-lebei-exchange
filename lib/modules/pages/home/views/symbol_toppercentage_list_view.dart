import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_toppercentage_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/shimmer_list_view.dart';
import 'package:get/get.dart';

class SymbolTopPercentageList extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.tickerController.loading.isTrue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SymbolTopPercentageListViewHeader(),
            Expanded(
              child: controller.tickerController.loading.isTrue
                  ? const ShimmerListView()
                  : NestedScrollViewInnerScrollPositionKeyWidget(
                      Key(controller.tabStrings.first),
                      SymbolTopPercentageListView(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymbolTopPercentageListView extends GetView<SymbolTopPercentageListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        key: key,
        itemBuilder: (BuildContext context, int index) => TickerPercentageListTile(controller.tickers[index]),
        itemCount: controller.tickers.length,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (_, int _i) => const Divider(height: 1.0),
      ),
    );
  }
}

class SymbolTopPercentageListViewHeader extends GetView<SymbolTopPercentageListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HomeListViewHeader(
        first: InkWell(
          onTap: () {
            if (controller.sortType.value == SortType.symbolDesc) {
              controller.sortType.value = SortType.symbolAsc;
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
