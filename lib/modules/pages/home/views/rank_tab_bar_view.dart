import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class RankTabBarView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 48.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              tabs: controller.tabStrings
                  .map(
                    (t) => Tab(
                      text: t.tr,
                      key: Key(t),
                    ),
                  )
                  .toList(),
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
            ),
          ),
          Divider(height: 1.0),
        ],
      ),
    );
  }
}
