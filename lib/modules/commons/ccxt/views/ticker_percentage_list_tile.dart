import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/ccxt/ticker.dart';
import '../../settings/controller/settings_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/symbol_controller.dart';
import '../helpers/percentage.dart';
import '../helpers/symbol.dart';
import '../helpers/ticker.dart';

class TickerPercentageListTile extends StatelessWidget {
  TickerPercentageListTile(this.ticker);
  final Ticker ticker;

  final SymbolController symbolController = Get.find<SymbolController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SymbolHelper.getSymbolTitle(ticker.symbol),
              SymbolHelper.getSymbolSubtitle(
                ticker.symbol,
                settingsController.advanceDeclineColors,
              ),
            ],
          ),
          Obx(
            () => Text(
              marketController.formatPriceByPrecision(
                TickerHelper.getValuablePrice(ticker),
                ticker.symbol,
              ),
            ),
          ),
        ],
      ),
      trailing: SizedBox(
        width: 96.0,
        child: Obx(
          () => PercentageHelper.getPercentageButton(settingsController.advanceDeclineColors, ticker.percentage),
        ),
      ),
      selected: symbolController.favoriteSymbols.any((String s) => s == ticker.symbol),
      selectedTileColor: Theme.of(context).accentColor.withOpacity(.1),
      onTap: () {
        symbolController.onChangeCurrentSymbol(ticker.symbol);
        Get.toNamed('/market');
      },
      onLongPress: () => symbolController.toggleFavoriteSymbol(ticker.symbol),
      enableFeedback: true,
    );
  }
}
