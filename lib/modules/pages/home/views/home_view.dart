import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topbasevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_toppercentage_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/symbol_topquotevolume_list_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/banner_view.dart';
// import 'package:flutter_lebei_exchange/modules/pages/home/views/googlead_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/guide_list_tile.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/list_view_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/notice_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/pulltorefresh_header.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/shortcut_grid_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/rank_tab_bar_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/symbol_popular_grid_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/symbol_topbasevolume_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/symbol_toppercentage_list_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/symbol_topquotevolume_list_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

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
          icon: Icon(Icons.person),
          onPressed: () => Get.toNamed('/settings'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lunch_dining),
            onPressed: () => Get.toNamed('/exchanges'),
          ),
        ],
      ),
      body: Obx(
        () => PullToRefreshNotification(
          onRefresh: controller.refreshPageData,
          maxDragOffset: HomePullToRefreshHeader.maxDragOffset,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool) => <Widget>[
              PullToRefreshContainer(
                (PullToRefreshScrollNotificationInfo? info) => SliverToBoxAdapter(child: HomePullToRefreshHeader(info)),
              ),
              SliverToBoxAdapter(child: HomeBannerView()),
              // SliverToBoxAdapter(child: HomeGoogleAdBannerView()),
              SliverToBoxAdapter(child: HomeNoticeView()),
              SliverToBoxAdapter(child: Divider(height: 1.0)),
              SliverToBoxAdapter(child: SymbolPopularGridView()),
              SliverToBoxAdapter(child: HomeGuideListTile()),
              // SliverToBoxAdapter(child: HomeGoogleAdListTile()),
              SliverToBoxAdapter(child: HomeShortcutGridView()),
            ],
            pinnedHeaderSliverHeightBuilder: () => 0,
            innerScrollPositionKeyBuilder: () => controller.innerScrollPositionKey.value,
            body: Column(
              children: [
                RankTabBarView(),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      GetBuilder<SymbolTopPercentageListController>(
                        init: SymbolTopPercentageListController(),
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SymbolTopPercentageListViewHeader(),
                            Expanded(
                              child: NestedScrollViewInnerScrollPositionKeyWidget(
                                Key(controller.tabStrings.first),
                                SymbolTopPercentageListView(key: Key(controller.tabStrings.first)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<SymbolTopBaseVolumeListController>(
                        init: SymbolTopBaseVolumeListController(),
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SymbolTopBaseVolumeListViewHeader(),
                            Expanded(
                              child: NestedScrollViewInnerScrollPositionKeyWidget(
                                Key(controller.tabStrings[1]),
                                SymbolTopBaseVolumeListView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<SymbolTopQuoteVolumeListController>(
                        init: SymbolTopQuoteVolumeListController(),
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SymbolTopQuoteVolumeListViewHeader(),
                            Expanded(
                              child: NestedScrollViewInnerScrollPositionKeyWidget(
                                Key(controller.tabStrings[2]),
                                SymbolTopQuoteVolumeListView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
      ),
    );
  }
}
