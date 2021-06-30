// import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flustars/flustars.dart';
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

  final TextEditingController bidPriceController = TextEditingController();
  final TextEditingController askPriceController = TextEditingController();
  final TextEditingController bidAmountController = TextEditingController();
  final TextEditingController askAmountController = TextEditingController();
  final RxDouble bidPrice = 0.0.obs;
  final RxDouble askPrice = 0.0.obs;
  final RxDouble bidAmount = 0.0.obs;
  final RxDouble askAmount = 0.0.obs;
  final RxString _bidTotal = '--'.obs;
  final RxString _askTotal = '--'.obs;

  String get bidTotal => _bidTotal.value;
  String get askTotal => _askTotal.value;

  // TODO: formatPriceByPrecision
  set bidTotal(String t) => _bidTotal.value = t;
  set askTotal(String t) => _askTotal.value = t;

  final List<String> orderTypes = <String>[
    'TradesPage.OrderType.market',
    'TradesPage.OrderType.limit',
    'TradesPage.OrderType.stop',
    'TradesPage.OrderType.trigger',
  ];

  final RxString orderType = 'TradesPage.OrderType.limit'.obs;

  @override
  void onInit() {
    super.onInit();
    bidPriceController.addListener(watchBidPriceController);
    askPriceController.addListener(watchAskPriceController);
    bidAmountController.addListener(watchBidAmountController);
    askAmountController.addListener(watchAskAmountController);

    debounce(bidPrice, watchBid, time: const Duration(milliseconds: 300));
    debounce(askPrice, watchAsk, time: const Duration(milliseconds: 300));
    debounce(bidAmount, watchBid, time: const Duration(milliseconds: 300));
    debounce(askAmount, watchAsk, time: const Duration(milliseconds: 300));
    debounce(orderType, watchOrderType, time: const Duration(milliseconds: 300));
    ever(symbolController.currentSymbol, watchOrderType);
  }

  @override
  void onClose() {
    bidPriceController.removeListener(watchBidPriceController);
    askPriceController.removeListener(watchAskPriceController);
    bidAmountController.removeListener(watchBidAmountController);
    askAmountController.removeListener(watchAskAmountController);
    super.onClose();
  }

  void watchBid(double p) {
    final double total = bidPrice.value * bidAmount.value;
    bidTotal = total == 0.0 ? '--' : total.toString();
  }

  void watchAsk(double p) {
    final double total = askPrice.value * askAmount.value;
    askTotal = total == 0.0 ? '--' : total.toString();
  }

  void watchOrderType(String type) {
    bidPriceController.clear();
    bidAmountController.clear();
    askPriceController.clear();
    askAmountController.clear();
  }

  void watchBidPriceController() {
    bidPrice.value = NumUtil.getDoubleByValueStr(bidPriceController.text) ?? 0.0;
  }

  void watchAskPriceController() {
    askPrice.value = NumUtil.getDoubleByValueStr(askPriceController.text) ?? 0.0;
  }

  void watchBidAmountController() {
    bidAmount.value = NumUtil.getDoubleByValueStr(bidAmountController.text) ?? 0.0;
  }

  void watchAskAmountController() {
    askAmount.value = NumUtil.getDoubleByValueStr(askAmountController.text) ?? 0.0;
  }

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
