import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:flutter_lebei_exchange/modules/commons/keep_alive_widget.dart';
import 'package:flutter_lebei_exchange/modules/pages/balance/views/balances_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/views/home_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/views/markets_view.dart';
import 'package:flutter_lebei_exchange/modules/pages/trade/views/trades_view.dart';

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
      child: TradesView(),
    ),
    KeepAliveWidget(
      child: BalancesView(),
    ),
  ];
  // List<Widget> pages = <Widget>[
  //   HomeView(),
  //   MarketsView(),
  //   Container(color: Colors.pink),
  //   BalancesView(),
  // ];
  List<BottomNavyBarItem> bottomNavyBarItems(BuildContext context) => <BottomNavyBarItem>[
        BottomNavyBarItem(
          title: Text('MainBottomNavy.Home'.tr),
          icon: const Icon(Icons.home),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('MainBottomNavy.Market'.tr),
          icon: const Icon(Icons.assessment),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('MainBottomNavy.Trade'.tr),
          icon: const Icon(Icons.coffee),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
        BottomNavyBarItem(
          title: Text('MainBottomNavy.Asset'.tr),
          icon: const Icon(Icons.person),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).accentColor,
        ),
      ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
