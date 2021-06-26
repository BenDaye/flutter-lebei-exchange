// import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/symbol_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';

enum InfoMenu {
  exchange,
  ticker,
  market,
}

class TradesViewController extends GetxController {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  final SymbolController symbolController = Get.find<SymbolController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final RxBool showOrderBook = true.obs;

  void showExchangeInfoBottomSheet() {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * .6,
        child: Obx(
          () => Column(
            children: <Widget>[
              ListTile(
                leading: ExtendedImage.asset(
                  'images/ccxt/${exchangeController.currentExchangeId.value}.jpg',
                  height: 25.0,
                  width: 85.0,
                  loadStateChanged: (ExtendedImageState state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Image.asset('images/ccxt/fail.png');
                    }
                  },
                ),
                title: Text(exchangeController.currentExchange.value.name),
                tileColor: Get.context?.theme.scaffoldBackgroundColor,
                trailing: CloseButton(onPressed: Get.back),
                contentPadding: const EdgeInsets.only(left: 16, top: 2, bottom: 2),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.version'.tr),
                      trailing: Text(exchangeController.currentExchange.value.version),
                    ),
                    const Divider(height: 1, indent: 16),
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.country'.tr),
                      trailing: Text(exchangeController.currentExchange.value.countries.join(',')),
                    ),
                    const Divider(height: 1, indent: 16),
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.timeframes'.tr),
                      trailing: Text(
                        (exchangeController.currentExchange.value.timeframes == null ||
                                exchangeController.currentExchange.value.timeframes!.isEmpty)
                            ? ''
                            : exchangeController.currentExchange.value.timeframes!.keys.join(','),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(height: 1, indent: 16),
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.rateLimit'.tr),
                      trailing: Text('${exchangeController.currentExchange.value.rateLimit}'),
                    ),
                    const Divider(height: 1, indent: 16),
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.requiredCredentials'.tr),
                      trailing: Text(
                          '${exchangeController.currentExchange.value.requiredCredentials.entries.where((MapEntry<String, bool> e) => e.value).map((MapEntry<String, bool> e) => e.key)..toList().join(',')}'),
                    ),
                    const Divider(height: 1, indent: 16),
                    ListTile(
                      dense: true,
                      title: Text('Exchange.Info.has'.tr),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: exchangeController.currentExchange.value.has
                              .toJson()
                              .entries
                              .map(
                                (MapEntry<String, dynamic> e) => IgnorePointer(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: e.value == true
                                          ? Colors.green
                                          : e.value == 'emulated'
                                              ? Colors.orange
                                              : Colors.grey,
                                      minimumSize: const Size(20, 20),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      elevation: 0,
                                    ),
                                    child: Text(e.key),
                                  ),
                                ),
                                // ListTile(
                                //   dense: true,
                                //   title: Text(e.key),
                                //   trailing: Text('${e.value}'),
                                // ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    // ExpandablePanel(
                    //   theme: ExpandableThemeData(
                    //     iconColor: Get.context?.theme.textTheme.bodyText1?.color,
                    //     iconPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    //   ),
                    //   header: ListTile(
                    //     dense: true,
                    //     title: Text('Exchange.Info.has'.tr),
                    //   ),
                    //   collapsed: Container(),
                    //   expanded: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //     child: Wrap(
                    //       spacing: 8,
                    //       runSpacing: 8,
                    //       children: exchangeController.currentExchange.value.has
                    //           .toJson()
                    //           .entries
                    //           .map(
                    //             (MapEntry<String, dynamic> e) => IgnorePointer(
                    //               child: ElevatedButton(
                    //                 onPressed: () {},
                    //                 style: ElevatedButton.styleFrom(
                    //                   primary: e.value == true
                    //                       ? Colors.green
                    //                       : e.value == 'emulated'
                    //                           ? Colors.orange
                    //                           : Colors.grey,
                    //                   minimumSize: const Size(20, 20),
                    //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //                   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    //                 ),
                    //                 child: Text(e.key),
                    //               ),
                    //             ),
                    //             // ListTile(
                    //             //   dense: true,
                    //             //   title: Text(e.key),
                    //             //   trailing: Text('${e.value}'),
                    //             // ),
                    //           )
                    //           .toList(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Get.context?.theme.dialogBackgroundColor,
    );
  }

  void onInfoMenuSelected(InfoMenu menu) {
    switch (menu) {
      case InfoMenu.exchange:
        showExchangeInfoBottomSheet();
        break;
      default:
        break;
    }
  }
}
