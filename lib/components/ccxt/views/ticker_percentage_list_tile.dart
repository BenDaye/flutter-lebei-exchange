import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/controllers/symbol_controller.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/symbol_helper.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class TickerPercentageListTile extends StatelessWidget {
  final Ticker ticker;
  TickerPercentageListTile(this.ticker);

  final SymbolController symbolController = Get.find<SymbolController>();
  final SettingsController settingsController = Get.find<SettingsController>();

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
              SymbolHelper.getTitle(ticker.symbol),
              SymbolHelper.getSubtitle(ticker.symbol),
            ],
          ),
          Text('${ticker.bid?.toStringAsFixed(10)}'),
        ],
      ),
      trailing: Container(
        width: 88.0,
        child: Obx(
          () {
            return ElevatedButton(
              onPressed: () => null,
              child: Text(
                '${SymbolHelper.getPercentageSymbol(ticker.percentage)}${ticker.percentage?.toPrecision(2).toStringAsFixed(2)}%',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                primary: SymbolHelper.getPercentageColor(settingsController.advanceDeclineColors, ticker.percentage),
                elevation: 0,
              ),
            );
          },
        ),
      ),
      selected: symbolController.favoriteSymbols.any((s) => s == ticker.symbol),
      selectedTileColor: Theme.of(context).scaffoldBackgroundColor.withBlue(20),
      onTap: () => Get.toNamed('/market/${ticker.symbol.replaceAll('/', '_')}'),
      onLongPress: () => symbolController.toggleFavoriteSymbol(ticker.symbol),
      enableFeedback: true,
    );
  }
}
