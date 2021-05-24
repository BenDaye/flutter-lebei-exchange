import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_lebei_exchange/components/home/banner.dart';
import 'package:flutter_lebei_exchange/components/home/notice.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_base_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_percentage_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/symbol_top_quote_volume_list_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_guide_list_tile.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_list_header_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_shortcut_grid_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_popular_grid_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_base_volume_list_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_percentage_list_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/symbol_top_quote_volume_list_view.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeBeiGlobal'),
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Get.toNamed('/settings'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.line_style),
            onPressed: () => Get.toNamed('/exchanges'),
          ),
        ],
      ),
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool) => <Widget>[
            SliverToBoxAdapter(
              child: HomeBanner(),
            ),
            SliverToBoxAdapter(
              child: HomeNoticeBar(),
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
              Container(
                color: Theme.of(context).bottomAppBarColor,
                height: 48.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        tabs: controller.tabs,
                        controller: controller.tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                      ),
                    ),
                    Divider(height: 1.0),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Column(
                      children: [
                        HomeListHeaderView(first: '交易对', middle: '最新价', last: '涨跌幅'),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs.first.key!,
                            GetBuilder<SymbolTopPercentageListViewController>(
                              init: SymbolTopPercentageListViewController(),
                              initState: (_) {},
                              builder: (_) {
                                return SymbolTopPercentageListView(key: controller.tabs.first.key!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        HomeListHeaderView(first: '交易对', middle: '最新价', last: '成交量'),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs[1].key!,
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
                        HomeListHeaderView(first: '交易对', middle: '最新价', last: '成交额'),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs[2].key!,
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
                        HomeListHeaderView(first: '交易对', middle: '最新价', last: '成交额'),
                        Expanded(
                          child: NestedScrollViewInnerScrollPositionKeyWidget(
                            controller.tabs.last.key!,
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
