import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/market/controllers/markets_controller.dart';
import 'package:get/get.dart';

class CategoryTitleView extends GetView<MarketsViewController> {
  @override
  Widget build(BuildContext context) {
    TextStyle? categoryTextStyle(bool actived) => actived
        ? Theme.of(context).primaryTextTheme.headline6?.copyWith(
              color: Theme.of(context).accentColor,
            )
        : Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
              color: Theme.of(context).textTheme.caption?.color,
            );

    Widget toggleButton(String text, bool actived) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: categoryTextStyle(actived),
          ),
        );

    return Obx(
      () => ToggleButtons(
        isSelected: controller.selectedCategories,
        renderBorder: false,
        fillColor: Colors.transparent,
        onPressed: controller.onChangeCategory,
        children: <Widget>[
          toggleButton('MarketsPage.AppBar.Favorites'.tr, controller.selectedCategories[0]),
          toggleButton('MarketsPage.AppBar.Spot'.tr, controller.selectedCategories[1]),
          toggleButton('MarketsPage.AppBar.Margin'.tr, controller.selectedCategories[2]),
        ],
      ),
    );
  }
}
