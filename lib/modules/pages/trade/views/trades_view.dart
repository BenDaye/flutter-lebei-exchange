import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/orderbook_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/chart_controller.dart';
// import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/orderbook_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/orderbook_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/chart_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/orderbook_list_view.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/ticker_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/settings/controller/settings_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/market_drawer_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/trade/controllers/trades_controller.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/k_chart_widget.dart';

class TradesView extends GetView<TradesViewController> {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final MarketController marketController = Get.find<MarketController>();
  final TickerController tickerController = Get.find<TickerController>();
  final OrderBookListController orderBookListController = Get.find<OrderBookListController>(tag: 'TradePageOrderBook');
  final ChartController chartController = Get.find<ChartController>(tag: 'TradePageOhlcv');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: MarketDrawerView(),
      appBar: AppBar(
        title: Obx(
          () => InkWell(
            onTap: () => controller.scaffoldKey.currentState!.openDrawer(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.lunch_dining, size: 22),
                const SizedBox(width: 4.0),
                Text(
                  SymbolHelper.getSymbolTitleText(symbolController.currentSymbol.value.replaceAll('_', '/')),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(width: 4.0),
                PercentageHelper.getPercentageBadge(
                  settingsController.advanceDeclineColors,
                  tickerController.currentTicker.value.percentage,
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton<InfoMenu>(
            itemBuilder: (_) => <PopupMenuEntry<InfoMenu>>[
              PopupMenuItem<InfoMenu>(
                value: InfoMenu.ticker,
                child: Text('TradePage.InfoMenu.ticker'.tr),
              ),
              PopupMenuItem<InfoMenu>(
                value: InfoMenu.market,
                child: Text('TradePage.InfoMenu.market'.tr),
              ),
              PopupMenuItem<InfoMenu>(
                value: InfoMenu.exchange,
                child: Text('TradePage.InfoMenu.exchange'.tr),
              ),
            ],
            onSelected: controller.onInfoMenuSelected,
            offset: const Offset(0, 64),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Obx(
            () => ListTile(
              dense: true,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    marketController.formatPriceByPrecision(
                      TickerHelper.getValuablePrice(tickerController.currentTicker.value),
                      tickerController.currentTicker.value.symbol,
                    ),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: PercentageHelper.getPercentageColor(
                            settingsController.advanceDeclineColors,
                            tickerController.currentTicker.value.percentage,
                          ),
                        ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    TickerHelper(
                      ticker: tickerController.currentTicker.value,
                      currency: settingsController.currency.value,
                      currencyRate: settingsController.currencyRate.value,
                    ).formatPriceByRate(),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: controller.showOrderBook.toggle,
                icon: const Icon(Icons.list_alt),
                color: controller.showOrderBook.isTrue
                    ? Theme.of(context).accentColor
                    : Theme.of(context).unselectedWidgetColor,
              ),
              contentPadding: const EdgeInsets.only(left: 16),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: <Widget>[
                Obx(
                  () => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState:
                        controller.showOrderBook.isTrue ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: Container(
                      height: 156,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: <Widget>[
                          OrderBookListViewHeader(
                            marketController.currentMarket.value,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Column(
                            children: orderBookListController.bids
                                .take(5)
                                .toList()
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (MapEntry<int, List<double>> e) => OrderBookListTile(
                                    index: e.key + 1,
                                    bidAmount: e.value[1],
                                    bidAmountPercentage: e.value.last,
                                    bidPrice: e.value.first,
                                    askAmount: orderBookListController.asks[e.key][1],
                                    askAmountPercentage: orderBookListController.asks[e.key].last,
                                    askPrice: orderBookListController.asks[e.key].first,
                                    symbol: symbolController.currentSymbol.value,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    secondChild: IgnorePointer(
                      child: SizedBox(
                        height: 156,
                        width: double.infinity,
                        child: KChartWidget(
                          chartController.kline,
                          CustomChartStyle(),
                          CustomChartColors().copyWith(
                            upColor: settingsController.advanceDeclineColors.first,
                            dnColor: settingsController.advanceDeclineColors.last,
                          ),
                          isLine: true,
                          mainState: MainState.NONE,
                          secondaryState: SecondaryState.NONE,
                          volHidden: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
