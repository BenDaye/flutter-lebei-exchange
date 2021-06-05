import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/exchange/controllers/exchange_view_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExchangesView extends GetView<ExchangeViewController> {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ExchangesPage.AppBar.Title'.tr)),
      body: Obx(
        () => Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
              children: [
                ListTile(
                  title: Text('ExchangesPage.CurrentExchange'.tr),
                  trailing: Text(
                    ExchangeController.getExchangeName(exchangeController.currentExchangeId.value),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                  selected: true,
                  selectedTileColor: Theme.of(context).accentColor.withOpacity(.1),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Wrap(
                      spacing: 16,
                      children: [
                        OutlinedButton(
                          onPressed: () => exchangeController.updateCurrentExchangeId('huobipro'),
                          child: Text(ExchangeController.getExchangeName('huobipro')),
                        ),
                        OutlinedButton(
                          onPressed: () => exchangeController.updateCurrentExchangeId('binance'),
                          child: Text(ExchangeController.getExchangeName('binance')),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1),
                // ValueListenableBuilder(
                //   valueListenable: controller.itemPositionsListener.itemPositions,
                //   builder: (BuildContext context, Iterable<ItemPosition> positions, child) {
                //     int? max;
                //     int? min;
                //     if (positions.isNotEmpty) {
                //       min = positions
                //           .where((p) => p.itemTrailingEdge > 0)
                //           .reduce((m, p) => p.itemTrailingEdge < m.itemTrailingEdge ? p : m)
                //           .index;
                //       max = positions
                //           .where((p) => p.itemTrailingEdge > 0)
                //           .reduce((m, p) => p.itemTrailingEdge > m.itemTrailingEdge ? p : m)
                //           .index;
                //     }
                //     return Row(
                //       children: [
                //         Expanded(child: Text('Max: $max')),
                //         Expanded(child: Text('Min: $min')),
                //       ],
                //     );
                //   },
                // ),
                Expanded(
                  child: SafeArea(
                    child: RefreshIndicator(
                      onRefresh: exchangeController.getExchanges,
                      child: ScrollablePositionedList.separated(
                        separatorBuilder: (BuildContext context, int index) => Divider(indent: 16, height: 1.0),
                        itemCount: exchangeController.exchanges.length,
                        itemBuilder: (BuildContext context, int index) => ListTile(
                          leading: ExtendedImage.asset(
                            'images/ccxt/${exchangeController.exchanges[index]}.jpg',
                            height: 25.0,
                            width: 85.0,
                            loadStateChanged: (state) {
                              if (state.extendedImageLoadState == LoadState.failed)
                                return Image.asset('images/ccxt/fail.png');
                            },
                          ),
                          title:
                              Obx(() => Text(ExchangeController.getExchangeName(exchangeController.exchanges[index]))),
                          selected: exchangeController.currentExchangeId.value == exchangeController.exchanges[index],
                          onTap: () => exchangeController.updateCurrentExchangeId(exchangeController.exchanges[index]),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: exchangeController.currentExchangeId.value == exchangeController.exchanges[index]
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        itemPositionsListener: controller.itemPositionsListener,
                        itemScrollController: controller.itemScrollController,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // color: Theme.of(context).backgroundColor,
              child: GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  controller.currentOffsetY.value = details.localPosition.dy;
                },
                onTapDown: (TapDownDetails details) {
                  controller.currentOffsetY.value = details.localPosition.dy;
                },
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.indexes
                      .map(
                        (i) => Container(
                          width: 32,
                          height: controller.itemHeight.value,
                          padding: const EdgeInsets.only(right: 4),
                          child: Center(
                            child: Text(
                              i,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
