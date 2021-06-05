import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/helpers/number_helper.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_top_base_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SymbolTopBaseVolumeListView extends GetView<SymbolTopBaseVolumeListViewController> {
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
                  CcxtHelper.getSymbolTitle(controller.tickers[index].symbol),
                  CcxtHelper.getSymbolSubtitle(
                    controller.tickers[index].symbol,
                    settingsController.advanceDeclineColors,
                  ),
                ],
              ),
              Text('${marketController.formatPriceByPrecision(controller.tickers[index])}'),
            ],
          ),
          trailing: Container(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () => null,
              child: Text(
                NumberHelper(
                  locale: settingsController.locale.value,
                ).getNumberDisplay(controller.tickers[index].baseVolume).text,
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
