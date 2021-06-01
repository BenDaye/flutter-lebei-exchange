import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_drawer_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class MarketDrawerView extends StatelessWidget {
  final MarketDrawerViewController marketDrawerViewController = Get.put(MarketDrawerViewController());
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final MarketViewController marketViewController = Get.find<MarketViewController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              tabs: marketDrawerViewController.tabs
                  .map(
                    (t) => Tab(
                      text: t.tr,
                      key: Key(t),
                    ),
                  )
                  .toList(),
              controller: marketDrawerViewController.tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
        body: Obx(
          () => ListView.builder(
            itemBuilder: (BuildContext context, int index) => ListTile(
              dense: true,
              title: CcxtHelper.getSymbolTitle(
                marketDrawerViewController.tickers[index].symbol,
                baseTextStyle: Get.context?.textTheme.bodyText2,
              ),
              trailing: Text(
                '${marketController.formatPriceByPrecision(marketDrawerViewController.tickers[index])}',
                style: TextStyle(
                  color: CcxtHelper.getPercentageColor(
                    settingsController.advanceDeclineColors,
                    marketDrawerViewController.tickers[index].percentage,
                  ),
                ),
              ),
              selected: marketViewController.symbol.value.replaceAll('_', '/') ==
                  marketDrawerViewController.tickers[index].symbol,
              selectedTileColor: Theme.of(context).accentColor.withOpacity(.2),
              onTap: () {
                marketViewController.symbol.value =
                    marketDrawerViewController.tickers[index].symbol.replaceAll('/', '_');
                Get.back();
              },
            ),
            itemCount: marketDrawerViewController.tickers.length,
          ),
        ),
      ),
    );
  }
}
