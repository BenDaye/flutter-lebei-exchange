import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
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
              CcxtHelper.getSymbolTitle(ticker.symbol),
              CcxtHelper.getSymbolSubtitle(
                ticker.symbol,
                settingsController.advanceDeclineColors,
              ),
            ],
          ),
          Obx(
            () => Text('${marketController.formatPriceByPrecision(ticker)}'),
          ),
        ],
      ),
      trailing: Container(
        width: 96.0,
        child: Obx(
          () => CcxtHelper.getPercentageButton(settingsController.advanceDeclineColors, ticker.percentage),
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
