import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topbasevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SymbolTopBaseVolumeListView extends GetView<SymbolTopBaseVolumeListController> {
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SymbolHelper.getSymbolTitle(controller.tickers[index].symbol),
                  SymbolHelper.getSymbolSubtitle(
                    controller.tickers[index].symbol,
                    settingsController.advanceDeclineColors,
                  ),
                ],
              ),
              Text(
                marketController.formatPriceByPrecision(
                  TickerHelper.getValuablePrice(controller.tickers[index]),
                  controller.tickers[index].symbol,
                ),
              ),
            ],
          ),
          trailing: Container(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () => null,
              child: Text(
                NumberHelper(locale: settingsController.locale.value)
                    .getNumberDisplay(controller.tickers[index].baseVolume)
                    .text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                elevation: 0,
              ),
            ),
          ),
        ),
        itemCount: controller.tickers.length,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class SymbolTopBaseVolumeListViewHeader extends GetView<SymbolTopBaseVolumeListController> {
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
            if (controller.sortType.value == SortType.BaseVolDesc) {
              controller.sortType.value = SortType.BaseVolAsc;
            } else {
              controller.sortType.value = SortType.BaseVolDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ListViewHeader.BaseVolume'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              controller.sortType.value == SortType.BaseVolDesc
                  ? Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
                  : controller.sortType.value == SortType.BaseVolAsc
                      ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                      : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
      ),
    );
  }
}
