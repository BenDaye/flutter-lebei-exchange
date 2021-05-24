import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/ccxt/helpers/symbol_helper.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_base_volume_list_view_controller.dart';
import 'package:get/get.dart';

class SymbolTopBaseVolumeListView extends GetView<SymbolTopBaseVolumeListViewController> {
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
                  SymbolHelper.getTitle(controller.tickers[index].symbol),
                  SymbolHelper.getSubtitle(controller.tickers[index].symbol),
                ],
              ),
              Text('${controller.tickers[index].bid?.toStringAsFixed(8)}'),
            ],
          ),
          trailing: Container(
            width: 88.0,
            child: ElevatedButton(
              onPressed: () => null,
              child: Text(
                '${NumUtil.divide(controller.tickers[index].baseVolume ?? 0, 100 * 1000 * 1000).toStringAsFixed(2)}亿',
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
