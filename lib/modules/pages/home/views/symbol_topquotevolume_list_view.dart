import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topquotevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/shimmer_list_view.dart';

class SymbolTopQuoteVolumeList extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: controller.tickerController.loading.isTrue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SymbolTopQuoteVolumeListViewHeader(),
          Expanded(
            child: controller.tickerController.loading.isTrue
                ? const ShimmerListView()
                : NestedScrollViewInnerScrollPositionKeyWidget(
                    Key(controller.tabStrings[2]),
                    SymbolTopQuoteVolumeListView(),
                  ),
          ),
        ],
      ),
    );
  }
}

class SymbolTopQuoteVolumeListView extends GetView<SymbolTopQuoteVolumeListController> {
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
          trailing: SizedBox(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                elevation: 0,
              ),
              child: Text(
                NumberHelper.getCurrencySymbol(
                      settingsController.currency.value,
                    ) +
                    NumberHelper(
                      currencyRate: settingsController.currencyRate.value,
                      locale: settingsController.locale.value,
                    )
                        .getNumberDisplay(
                          controller.tickers[index].quoteVolume,
                        )
                        .text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        itemCount: controller.tickers.length,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class SymbolTopQuoteVolumeListViewHeader extends GetView<SymbolTopQuoteVolumeListController> {
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
            if (controller.sortType.value == SortType.quoteVolDesc) {
              controller.sortType.value = SortType.quoteVolAsc;
            } else {
              controller.sortType.value = SortType.quoteVolDesc;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'ListViewHeader.QuoteVolume'.tr,
                style: Theme.of(context).textTheme.caption,
              ),
              if (controller.sortType.value == SortType.quoteVolDesc)
                Icon(Icons.trending_down, size: 12, color: Theme.of(context).unselectedWidgetColor)
              else
                controller.sortType.value == SortType.quoteVolAsc
                    ? Icon(Icons.trending_up, size: 12, color: Theme.of(context).unselectedWidgetColor)
                    : Icon(Icons.swap_vert, size: 12, color: Theme.of(context).unselectedWidgetColor),
            ],
          ),
        ),
      ),
    );
  }
}
