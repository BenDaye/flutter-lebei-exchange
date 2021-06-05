import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/common/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_view_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/exchange_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/exchange_list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/market_drawer_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/ohlcv_chart_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/orderbook_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/orderbook_list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/ticker_card_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/trade_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/trade_list_view_header.dart';
import 'package:get/get.dart';

class MarketView extends GetView<MarketViewController> {
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Obx(
          () => InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lunch_dining, size: 22),
                SizedBox(width: 4.0),
                Text(
                  CcxtHelper.getSymbolTitleText(symbolController.currentSymbol.value.replaceAll('_', '/')),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            onTap: () => controller.scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: BackButton(),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () =>
                  symbolController.toggleFavoriteSymbol(symbolController.currentSymbol.value.replaceAll('_', '/')),
              icon: symbolController.favoriteSymbols.contains(symbolController.currentSymbol.value.replaceAll('_', '/'))
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border, color: Theme.of(context).unselectedWidgetColor),
            ),
          ),
        ],
      ),
      drawer: MarketDrawerView(),
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool) => <Widget>[
            SliverToBoxAdapter(
              child: TickerCardView(),
            ),
            SliverToBoxAdapter(
              child: GetBuilder<MarketViewController>(
                id: 'ohlcv',
                builder: (_) => OhlcvChartView(),
              ),
            ),
          ],
          pinnedHeaderSliverHeightBuilder: () => 0,
          innerScrollPositionKeyBuilder: () => controller.innerScrollPositionKey.value,
          body: Column(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                height: 48.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        tabs: controller.tabs,
                        controller: controller.tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                      ),
                    ),
                    Divider(height: 1.0),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Column(
                      children: [
                        OrderBookListViewHeader(),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs.first.key!,
                            OrderBookListView(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TradeListViewHeader(),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs[1].key!,
                            TradeListView(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs[2].key!,
                            Container(
                              height: 1000,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ExchangeListViewHeader(),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs.last.key!,
                            ExchangeListView(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
