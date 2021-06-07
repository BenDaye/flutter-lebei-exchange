import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/symbol.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/ticker.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topquotevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SymbolTopQuoteVolumeListView extends StatelessWidget {
  final SymbolTopQuoteVolumeListController controller = Get.put(SymbolTopQuoteVolumeListController());
  final MarketController marketController = Get.find<MarketController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SymbolHelper.getSymbolTitle(controller.tickers[index].symbol),
                  SymbolHelper.getSymbolSubtitle(
                    controller.tickers[index].symbol,
                    settingsController.advanceDeclineColors,
                  ),
                ],
              ),
              Text('${marketController.formatPriceByPrecision(
                TickerHelper.getValuablePrice(controller.tickers[index]),
                controller.tickers[index].symbol,
              )}'),
            ],
          ),
          trailing: Container(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () => null,
              child: Text(
                NumberHelper.getCurrencySymbol(
                      settingsController.currency.value,
                    ) +
                    NumberHelper(
                      currencyRate: settingsController.currencyRate.value,
                      locale: settingsController.locale.value,
                    )
                        .getNumberDisplay(
                          controller.tickers[index].quoteVolume,
                        )
                        .text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                elevation: 0,
              ),
            ),
          ),
        ),
        itemCount: controller.tickers.length,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
