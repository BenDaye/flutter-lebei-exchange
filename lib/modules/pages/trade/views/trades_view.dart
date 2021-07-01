import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:k_chart/k_chart_widget.dart';

import '../../../commons/ccxt/controllers/exchange_controller.dart';
import '../../../commons/ccxt/controllers/market_controller.dart';
import '../../../commons/ccxt/controllers/symbol_controller.dart';
import '../../../commons/ccxt/controllers/ticker_controller.dart';
import '../../../commons/ccxt/helpers/percentage.dart';
import '../../../commons/ccxt/helpers/symbol.dart';
import '../../../commons/ccxt/helpers/ticker.dart';
import '../../../commons/ccxt/views/orderbook_list_tile.dart';
import '../../../commons/settings/controller/settings_controller.dart';
import '../../market/controllers/chart_controller.dart';
import '../../market/controllers/orderbook_list_controller.dart';
import '../../market/views/chart_view.dart';
import '../../market/views/market_drawer_view.dart';
import '../../market/views/orderbook_list_view.dart';
import '../controllers/trades_controller.dart';

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
    return GestureDetector(
      onPanDown: (_) {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
        body: Obx(
          () => IgnorePointer(
            ignoring: symbolController.currentSymbol.isEmpty,
            child: Column(
              children: <Widget>[
                ListTile(
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
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    children: <Widget>[
                      AnimatedCrossFade(
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
                                        onBidPriceTap: (double p) => controller.bidPriceController.text = p.toString(),
                                        onAskPriceTap: (double p) => controller.askPriceController.text = p.toString(),
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
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButtonFormField<String>(
                          items: controller.orderTypes
                              .map(
                                (String e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e.tr),
                                ),
                              )
                              .toList(),
                          onChanged: (String? orderType) => controller.orderType.value = orderType!,
                          value: controller.orderType.value,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: .5,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: .5,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(child: OrderDashboard()),
                            const SizedBox(width: 8),
                            Flexible(child: OrderDashboard(isBuy: false)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        color: Theme.of(context).backgroundColor,
                        child: ListTile(
                          title: Text('TradesPage.Orders.Title'.tr),
                          trailing: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert, size: 18),
                            label: Text('TradesPage.Orders.All'.tr),
                          ),
                        ),
                      ),
                    ],
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

class OrderDashboard extends GetView<TradesViewController> {
  OrderDashboard({this.isBuy = true});
  final bool isBuy;
  final TickerController tickerController = Get.find<TickerController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final SymbolController symbolController = Get.find<SymbolController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: .5, color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: isBuy ? controller.bidPriceController : controller.askPriceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: .5,
                        color: Colors.transparent,
                      ),
                    ),
                    filled: controller.orderType.value == 'TradesPage.OrderType.market',
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    hintText: controller.orderType.value != 'TradesPage.OrderType.market'
                        ? 'TradesPage.Order.Price'.tr
                        : 'TradesPage.Order.OptimalPrice'.tr,
                  ),
                  enabled: controller.orderType.value != 'TradesPage.OrderType.market',
                ),
              ),
              SizedBox(
                width: 32,
                height: 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 16,
                          color: Theme.of(context).textTheme.caption?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                          color: Theme.of(context).textTheme.caption?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Opacity(
            opacity: (controller.orderType.value == 'TradesPage.OrderType.market' ||
                    settingsController.currency.value == 'USD')
                ? 0
                : 1,
            child: Obx(
              () => Text(
                '≈ ${TickerHelper(
                  ticker: tickerController.currentTicker.value,
                  currency: settingsController.currency.value,
                  currencyRate: settingsController.currencyRate.value,
                ).formatPriceByRate(
                  showCurrency: false,
                  price: isBuy ? controller.bidPrice.value : controller.askPrice.value,
                )} ${settingsController.currency.value}',
                textAlign: isBuy ? TextAlign.left : TextAlign.right,
                maxLines: 1,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
            border: Border.all(width: .5, color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: isBuy ? controller.bidAmountController : controller.askAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: .5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: .5,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      symbolController.currentSymbol.isNotEmpty
                          ? symbolController.currentSymbol.split('_').first
                          : '--',
                    ),
                  ),
                  // ignore: avoid_redundant_argument_values
                  suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
                  hintText: 'TradesPage.Order.Amount'.tr,
                ),
              ),
              SizedBox(
                height: 32,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          '25%',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Center(
                        child: Text(
                          '50%',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Center(
                        child: Text(
                          '75%',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Center(
                        child: Text(
                          '100%',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('TradesPage.Order.Total'.tr),
              Obx(
                () => Text(
                  '${isBuy ? controller.bidTotal : controller.askTotal} ${symbolController.currentSymbol.split('_').last}',
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: ElevatedButton(
            onPressed: () => Get.snackbar(
              'Common.Text.Tips'.tr,
              'TODO',
              duration: const Duration(milliseconds: 2000),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orangeAccent.withOpacity(.2),
            ),
            style: ElevatedButton.styleFrom(
              primary:
                  isBuy ? settingsController.advanceDeclineColors.first : settingsController.advanceDeclineColors.last,
            ),
            child: Text(
              isBuy ? 'TradesPage.Order.Buy'.tr : 'TradesPage.Order.Sell'.tr,
            ),
          ),
        ),
      ],
    );
  }
}
