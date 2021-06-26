import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_drawer_controller.dart';

class MarketDrawerView extends StatelessWidget {
  final MarketDrawerController marketDrawerViewController = Get.put(MarketDrawerController());
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Drawer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: marketDrawerViewController.tabs
                    .map(
                      (String t) => Tab(
                        text: t.tr,
                        key: Key(t),
                      ),
                    )
                    .toList(),
                controller: marketDrawerViewController.tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            centerTitle: false,
          ),
          body: Obx(
            () => Column(
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Theme.of(context).focusColor,
                          child: TextField(
                            controller: marketDrawerViewController.textEditingController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                size: 16,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                              border: InputBorder.none,
                              counterStyle: const TextStyle(height: double.minPositive),
                              counterText: '',
                            ),
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 12,
                          ),
                        ),
                      ),
                      Obx(
                        () => marketDrawerViewController.query.isEmpty
                            ? Container()
                            : InkWell(
                                onTap: () => marketDrawerViewController.textEditingController.clear(),
                                child: Container(
                                  width: 48,
                                  color: Theme.of(context).focusColor,
                                  child: Center(
                                    child: Icon(
                                      Icons.clear,
                                      size: 16,
                                      color: Theme.of(context).unselectedWidgetColor,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      dense: true,
                      title: SymbolHelper.getSymbolTitle(
                        marketDrawerViewController.tickers[index].symbol,
                        baseTextStyle: Get.context?.textTheme.bodyText2,
                      ),
                      trailing: Text(
                        marketController.formatPriceByPrecision(
                          TickerHelper.getValuablePrice(marketDrawerViewController.tickers[index]),
                          marketDrawerViewController.tickers[index].symbol,
                        ),
                        style: TextStyle(
                          color: PercentageHelper.getPercentageColor(
                            settingsController.advanceDeclineColors,
                            marketDrawerViewController.tickers[index].percentage,
                          ),
                        ),
                      ),
                      selected: symbolController.currentSymbol.value.replaceAll('_', '/') ==
                          marketDrawerViewController.tickers[index].symbol,
                      selectedTileColor: Theme.of(context).accentColor.withOpacity(.2),
                      onTap: () {
                        symbolController.onChangeCurrentSymbol(marketDrawerViewController.tickers[index].symbol);
                        Get.back();
                      },
                    ),
                    itemCount: marketDrawerViewController.tickers.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
