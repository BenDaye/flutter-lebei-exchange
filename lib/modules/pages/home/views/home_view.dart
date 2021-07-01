import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'banner_view.dart';
import 'list_view_header.dart';
import 'notice_view.dart';
import 'rank_tab_bar_view.dart';
import 'shortcut_grid_view.dart';
import 'symbol_popular_grid_view.dart';
import 'symbol_topbasevolume_list_view.dart';
import 'symbol_toppercentage_list_view.dart';
import 'symbol_topquotevolume_list_view.dart';

class HomeView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'LeBei Globel',
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Get.toNamed('/settings'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.lunch_dining),
            onPressed: () => Get.toNamed('/exchanges'),
          ),
        ],
      ),
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool? bool) => <Widget>[
            SliverToBoxAdapter(child: HomeBannerView()),
            SliverToBoxAdapter(child: HomeNoticeView()),
            const SliverToBoxAdapter(child: Divider(height: 1.0)),
            SliverToBoxAdapter(child: SymbolPopularGridView()),
            SliverToBoxAdapter(child: HomeShortcutGridView()),
          ],
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          pinnedHeaderSliverHeightBuilder: () => 0,
          innerScrollPositionKeyBuilder: () => controller.innerScrollPositionKey.value,
          body: controller.settingsController.connectivityResult.value == ConnectivityResult.none
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.network_check,
                        size: 88,
                        color: Theme.of(context).disabledColor,
                      ),
                      Text(
                        'Common.networkError'.tr,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
                      ElevatedButton(
                        onPressed: () => controller.refreshPageData(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).errorColor,
                        ),
                        child: Text('Common.reload'.tr),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RankTabBarView(),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: <Widget>[
                          SymbolTopPercentageList(),
                          SymbolTopBaseVolumeList(),
                          SymbolTopQuoteVolumeList(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              HomeListViewHeader(
                                firstText: 'ListViewHeader.Symbol'.tr,
                                middleText: 'ListViewHeader.LastPrice'.tr,
                                lastText: 'ListViewHeader.QuoteVolume'.tr,
                              ),
                              Expanded(
                                child: NestedScrollViewInnerScrollPositionKeyWidget(
                                  Key(controller.tabStrings.last),
                                  Container(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
