import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/views/ticker_percentage_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_toppercentage_list_controller.dart';
import 'package:get/get.dart';

class SymbolTopPercentageListView extends StatelessWidget {
  final SymbolTopPercentageListController controller = Get.put(SymbolTopPercentageListController());
  final Key key;
  SymbolTopPercentageListView({required this.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        key: this.key,
        itemBuilder: (BuildContext context, int index) => TickerPercentageListTile(controller.tickers[index]),
        itemCount: controller.tickers.length,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (_, int _i) => Divider(height: 1.0),
      ),
    );
  }
}
