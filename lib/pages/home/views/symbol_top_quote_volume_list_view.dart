import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/helper.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_quote_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SymbolTopQuoteVolumeListView extends GetView<SymbolTopQuoteVolumeListViewController> {
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
              Text('${controller.tickers[index].bid ?? 0}'),
            ],
          ),
          trailing: Container(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () => null,
              child: Text(
                '${MoneyUtil.YUAN}${NumUtil.multiply(NumUtil.divide(controller.tickers[index].quoteVolume ?? 0, 100 * 1000 * 1000), 7).toStringAsFixed(2)}亿',
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
