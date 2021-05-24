import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/components/keep_alive_widget.dart';
import 'package:flutter_lebei_exchange/pages/asset/views/assets_view.dart';
import 'package:flutter_lebei_exchange/pages/home/views/home_view.dart';
import 'package:flutter_lebei_exchange/pages/market/views/markets_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController;
  List<KeepAliveWidget> pages = <KeepAliveWidget>[
    KeepAliveWidget(
      child: HomeView(),
    ),
    KeepAliveWidget(
      child: MarketsView(),
    ),
    KeepAliveWidget(
      child: Container(
        color: Colors.pink,
        child: ElevatedButton(onPressed: SpUtil.clear, child: Text('data')),
      ),
    ),
    KeepAliveWidget(
      child: AssetsView(),
    ),
  ];
  List<BottomNavyBarItem> bottomNavyBarItems(context) => <BottomNavyBarItem>[
        BottomNavyBarItem(
          title: Text('首页'),
          icon: Icon(Icons.home),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('行情'),
          icon: Icon(Icons.apps),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('交易'),
          icon: Icon(Icons.chat_bubble),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('资产'),
          icon: Icon(Icons.settings),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
      ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
