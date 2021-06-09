import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/market_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/panel_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/exchange_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/orderbook_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/trade_list_view.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MarketDataPanel extends GetView<MarketPanelController> {
  final MarketViewController marketViewController = Get.find<MarketViewController>();
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Theme.of(context).dialogBackgroundColor,
      backdropEnabled: true,
      maxHeight: MarketPanelController.panelMaxHeight,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      header: Container(
        height: MarketPanelController.panelHeaderHeight,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            height: 4,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).highlightColor,
            ),
          ),
        ),
      ),
      panel: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: Theme.of(context).dialogBackgroundColor,
          ),
          padding: const EdgeInsets.only(top: MarketPanelController.panelHeaderHeight),
          child: controller.panelSlide.value > .1
              ? Column(
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: MarketPanelController.panelTabBarHeight,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              tabs: marketViewController.tabs,
                              controller: marketViewController.tabController,
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                            ),
                          ),
                          Divider(height: 1.0),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: Get.width,
                        child: Center(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText(
                                'MarketPage.TabBar.More'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1,
                              ),
                              RotateAnimatedText(
                                'MarketPage.TabBar.Order'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1,
                              ),
                              RotateAnimatedText(
                                'MarketPage.TabBar.Trade'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1,
                              ),
                              RotateAnimatedText(
                                'MarketPage.TabBar.Intro'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1,
                              ),
                              RotateAnimatedText(
                                'MarketPage.TabBar.Exchanges'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1,
                              ),
                              RotateAnimatedText(
                                'MarketPage.TabBar.More'.tr,
                                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Theme.of(context).unselectedWidgetColor,
                                    ),
                                rotateOut: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      onPanelSlide: controller.onChangePanelSlide,
    );
  }
}

class MarketDataPanelBody extends GetView<MarketPanelController> {
  final MarketViewController marketViewController = Get.find<MarketViewController>();
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      vsync: marketViewController,
      alignment: Alignment.bottomCenter,
      child: Obx(
        () => Container(
          height: controller.panelTabViewHeight.value,
          width: Get.width,
          child: controller.panelSlide > 0.1
              ? AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: controller.panelSlide.value,
                  child: TabBarView(
                    controller: marketViewController.tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OrderBookListViewHeader(),
                          Divider(height: 1),
                          Expanded(child: OrderBookListView()),
                        ],
                      ),
                      Column(
                        children: [
                          TradeListViewHeader(),
                          Divider(height: 1),
                          Expanded(child: TradeListView()),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(child: Container(height: 1000, color: Colors.blue)),
                        ],
                      ),
                      Column(
                        children: [
                          ExchangeListViewHeader(),
                          Divider(height: 1),
                          Expanded(child: ExchangeListView()),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
