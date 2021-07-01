import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/helpers/symbol.dart';
import '../controllers/market_controller.dart';
import 'chart_view.dart';
import 'data_panel.dart';
import 'market_drawer_view.dart';
import 'ticker_card_view.dart';

class MarketView extends GetView<MarketViewController> {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      resizeToAvoidBottomInset: false,
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
              ],
            ),
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        actions: <Widget>[
          Obx(
            () => IconButton(
              onPressed: () =>
                  symbolController.toggleFavoriteSymbol(symbolController.currentSymbol.value.replaceAll('_', '/')),
              icon: symbolController.favoriteSymbols.contains(symbolController.currentSymbol.value.replaceAll('_', '/'))
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border, color: Theme.of(context).unselectedWidgetColor),
            ),
          ),
        ],
      ),
      drawer: MarketDrawerView(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              TickerCardView(),
              Expanded(child: ChartView()),
            ],
          ),
          MarketDataPanel(),
          Positioned(bottom: 0, child: MarketDataPanelBody()),
        ],
      ),
    );
  }
}
