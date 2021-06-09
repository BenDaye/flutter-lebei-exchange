import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/chart_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/chart_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/data_panel.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/market_drawer_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/ticker_card_view.dart';
import 'package:get/get.dart';

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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lunch_dining, size: 22),
                SizedBox(width: 4.0),
                Text(
                  SymbolHelper.getSymbolTitleText(symbolController.currentSymbol.value.replaceAll('_', '/')),
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
      body: Stack(
        children: [
          Column(
            children: [
              TickerCardView(),
              GetBuilder<ChartController>(
                id: 'chart',
                init: ChartController(),
                builder: (_) => ChartView(),
              ),
            ],
          ),
          MarketDataPanel(),
          Positioned(bottom: 0, child: MarketDataPanelBody()),
        ],
      ),
    );
  }
}
