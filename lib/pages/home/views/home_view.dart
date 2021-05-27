import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_base_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_percentage_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_quote_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_banner_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_guide_list_tile.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_list_header_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_notice_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_pulltorefresh_header_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_shortcut_grid_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/rank_tab_bar_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_popular_grid_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_base_volume_list_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_percentage_list_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_quote_volume_list_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomeView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('LeBeiGlobal'),
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
          maxDragOffset: 90,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool) => <Widget>[
              PullToRefreshContainer(
                (PullToRefreshScrollNotificationInfo? info) =>
                    SliverToBoxAdapter(child: HomePullToRefreshHeaderView(info)),
              ),
              SliverToBoxAdapter(
                child: HomeBannerView(),
              ),
              SliverToBoxAdapter(
                child: HomeNoticeView(),
              ),
              SliverToBoxAdapter(
                child: Divider(height: 1.0),
              ),
              SliverToBoxAdapter(
                child: SymbolPopularGridView(),
              ),
              SliverToBoxAdapter(
                child: HomeGuideListTile(),
              ),
              SliverToBoxAdapter(
                child: HomeShortcutGridView(),
              ),
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
                      Column(
                        children: [
                          HomeListHeaderView(
                            first: 'ListViewHeader.Symbol'.tr,
                            middle: 'ListViewHeader.LastPrice'.tr,
                            last: 'ListViewHeader.Change%'.tr,
                          ),
                          Expanded(
                            child: NestedScrollViewInnerScrollPositionKeyWidget(
                              Key(controller.tabStrings.first),
                              GetBuilder<SymbolTopPercentageListViewController>(
                                init: SymbolTopPercentageListViewController(),
                                initState: (_) {},
                                builder: (_) {
                                  return SymbolTopPercentageListView(key: Key(controller.tabStrings.first));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          HomeListHeaderView(
                            first: 'ListViewHeader.Symbol'.tr,
                            middle: 'ListViewHeader.LastPrice'.tr,
                            last: 'ListViewHeader.BaseVolume'.tr,
                          ),
                          Expanded(
                            child: NestedScrollViewInnerScrollPositionKeyWidget(
                              Key(controller.tabStrings[1]),
                              GetBuilder<SymbolTopBaseVolumeListViewController>(
                                init: SymbolTopBaseVolumeListViewController(),
                                initState: (_) {},
                                builder: (_) {
                                  return SymbolTopBaseVolumeListView();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          HomeListHeaderView(
                            first: 'ListViewHeader.Symbol'.tr,
                            middle: 'ListViewHeader.LastPrice'.tr,
                            last: 'ListViewHeader.QuoteVolume'.tr,
                          ),
                          Expanded(
                            child: NestedScrollViewInnerScrollPositionKeyWidget(
                              Key(controller.tabStrings[2]),
                              GetBuilder<SymbolTopQuoteVolumeListViewController>(
                                init: SymbolTopQuoteVolumeListViewController(),
                                initState: (_) {},
                                builder: (_) {
                                  return SymbolTopQuoteVolumeListView();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          HomeListHeaderView(
                            first: 'ListViewHeader.Symbol'.tr,
                            middle: 'ListViewHeader.LastPrice'.tr,
                            last: 'ListViewHeader.QuoteVolume'.tr,
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
