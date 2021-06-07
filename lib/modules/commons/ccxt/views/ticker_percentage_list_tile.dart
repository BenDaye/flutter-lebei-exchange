import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/percentage.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class TickerPercentageListTile extends StatelessWidget {
  final Ticker ticker;
  TickerPercentageListTile(this.ticker);

  final SymbolController symbolController = Get.find<SymbolController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      trailing: Container(
        width: 96.0,
        child: Obx(
          () => PercentageHelper.getPercentageButton(settingsController.advanceDeclineColors, ticker.percentage),
        ),
      ),
      selected: symbolController.favoriteSymbols.any((s) => s == ticker.symbol),
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
