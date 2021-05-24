import 'package:flutter/material.dart';

class HomeCategoryTabBar extends StatefulWidget {
  HomeCategoryTabBar({
    Key? key,
    this.index = 0,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  final int index;
  final List<Tab> tabs;
  final TabController controller;

  @override
  _HomeCategoryTabBarState createState() => _HomeCategoryTabBarState();
}

class _HomeCategoryTabBarState extends State<HomeCategoryTabBar> {
  void changeTab() {
    widget.controller.animateTo(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomAppBarColor,
      child: Column(
        children: [
          Container(
            height: 48.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                TabBar(
                  tabs: widget.tabs,
                  controller: widget.controller,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                Divider(height: 1.0),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).bottomAppBarColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '交易对',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '最新价',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 104.0,
                  child: Text(
                    '涨跌幅',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  SliverTabBarDelegate({
    required this.widget,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 73.0;

  @override
  double get minExtent => 73.0;
}
