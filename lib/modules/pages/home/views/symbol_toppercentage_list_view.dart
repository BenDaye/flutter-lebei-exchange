import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_toppercentage_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:get/get.dart';

class SymbolTopPercentageListView extends GetView<SymbolTopPercentageListController> {
  final Key key;
  SymbolTopPercentageListView({required this.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        key: this.key,
        itemBuilder: (BuildContext context, int index) => TickerPercentageListTile(controller.tickers[index]),
        itemCount: controller.tickers.length,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (_, int _i) => Divider(height: 1.0),
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
            if (controller.sortType.value == SortType.SymbolDesc) {
              controller.sortType.value = SortType.SymbolAsc;
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
