// ignore_for_file: overridden_fields,annotate_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../../commons/settings/controller/settings_controller.dart';
import '../controllers/chart_controller.dart';

class ChartView extends StatelessWidget {
  final SettingsController settingsController = Get.find<SettingsController>();
  final ChartController controller = Get.find<ChartController>(tag: 'MarketPageChart');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: <Widget>[
          SizedBox(
            height: 32,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    tabs: controller.timeframesTabs,
                    controller: controller.timeframesController,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    onTap: controller.handleClickTab,
                  ),
                ),
                const VerticalDivider(width: 1, indent: 8, endIndent: 8),
                InkWell(
                  onTap: () => controller.showSettings.toggle(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Tab(
                      child: Icon(
                        Icons.folder_special,
                        size: 16,
                        color: controller.showSettings.isTrue
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: controller.timeframe.value == 'depth'
                      ? DepthChart(
                          controller.depthBids,
                          controller.depthAsks,
                          CustomChartColors().copyWith(
                            upColor: settingsController.advanceDeclineColors.first,
                            dnColor: settingsController.advanceDeclineColors.last,
                          ),
                        )
                      : KChartWidget(
                          controller.kline,
                          CustomChartStyle(),
                          CustomChartColors().copyWith(
                            upColor: settingsController.advanceDeclineColors.first,
                            dnColor: settingsController.advanceDeclineColors.last,
                          ),
                          mainState: controller.mainState.value,
                          secondaryState: controller.secondaryState.value,
                        ),
                ),
                if (controller.showSettings.isTrue || controller.showExtra.isTrue)
                  InkWell(
                    onTap: () {
                      controller.showSettings.value = false;
                      controller.showExtra.value = false;
                    },
                    child: Container(
                      color: Colors.black26,
                    ),
                  )
                else
                  Container(height: 0),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: controller.showSettings.isTrue
                      ? Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Text('MarketPage.KChart.MainState'.tr),
                                  title: Wrap(
                                    spacing: 8,
                                    children: MainState.values
                                        .map(
                                          (MainState e) => ElevatedButton(
                                            onPressed: () => controller.mainState.value = e,
                                            style: ElevatedButton.styleFrom(
                                              primary: controller.mainState.value == e
                                                  ? Theme.of(context).primaryColor
                                                  : Theme.of(context).dividerColor,
                                              elevation: 0,
                                            ),
                                            child: Text(e.toString().split('.').last),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const Divider(height: 1),
                                ListTile(
                                  leading: Text('MarketPage.KChart.SecondaryState'.tr),
                                  title: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 8,
                                    children: SecondaryState.values
                                        .map(
                                          (SecondaryState e) => ElevatedButton(
                                            onPressed: () => controller.secondaryState.value = e,
                                            style: ElevatedButton.styleFrom(
                                              primary: controller.secondaryState.value == e
                                                  ? Theme.of(context).primaryColor
                                                  : Theme.of(context).dividerColor,
                                              elevation: 0,
                                            ),
                                            child: Text(e.toString().split('.').last),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(height: 0),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: controller.showExtra.isTrue
                      ? Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: ListTile(
                              title: Wrap(
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                children: controller.timeframesExtra
                                    .map<ElevatedButton>(
                                      (String e) => ElevatedButton(
                                        onPressed: () => controller.onChangeTimeframeExtra(e),
                                        style: ElevatedButton.styleFrom(
                                          primary: controller.timeframe.value == e
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).dividerColor,
                                          elevation: 0,
                                        ),
                                        child: Text('MarketPage.Period.$e'.tr),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        )
                      : Container(height: 0),
                ),
              ],
            ),
          ),
          Container(height: 100),
        ],
      ),
    );
  }
}

class CustomChartStyle extends ChartStyle {
  CustomChartStyle({
    this.pointWidth = 11.0,
    this.candleWidth = 6.5,
    this.candleLineWidth = 1.5,
    this.volWidth = 6.5,
    this.macdWidth = 3.0,
    this.vCrossWidth = 6.5,
    this.hCrossWidth = 0.5,
  });
  //点与点的距离
  final double pointWidth;

  //蜡烛宽度
  final double candleWidth;

  //蜡烛中间线的宽度
  final double candleLineWidth;

  //vol柱子宽度
  final double volWidth;

  //macd柱子宽度
  final double macdWidth;

  //垂直交叉线宽度
  final double vCrossWidth;

  //水平交叉线宽度
  final double hCrossWidth;

  CustomChartStyle copyWith({
    double? pointWidth,
    double? candleWidth,
    double? candleLineWidth,
    double? volWidth,
    double? macdWidth,
    double? vCrossWidth,
    double? hCrossWidth,
  }) =>
      CustomChartStyle(
        pointWidth: pointWidth ?? this.pointWidth,
        candleWidth: candleWidth ?? this.candleWidth,
        candleLineWidth: candleLineWidth ?? this.candleLineWidth,
        volWidth: volWidth ?? this.volWidth,
        macdWidth: macdWidth ?? this.macdWidth,
        vCrossWidth: vCrossWidth ?? this.vCrossWidth,
        hCrossWidth: hCrossWidth ?? this.hCrossWidth,
      );
}

class CustomChartColors extends ChartColors {
  CustomChartColors({
    this.kLineColor = const Color(0xff4C86CD),
    this.lineFillColor = const Color(0x554C86CD),
    this.ma5Color = const Color(0xffC9B885),
    this.ma10Color = const Color(0xff6CB0A6),
    this.ma30Color = const Color(0xff9979C6),
    this.upColor = const Color(0xff4DAA90),
    this.dnColor = const Color(0xffC15466),
    this.volColor = const Color(0xff4729AE),
    this.macdColor = const Color(0xff4729AE),
    this.difColor = const Color(0xffC9B885),
    this.deaColor = const Color(0xff6CB0A6),
    this.kColor = const Color(0xffC9B885),
    this.dColor = const Color(0xff6CB0A6),
    this.jColor = const Color(0xff9979C6),
    this.rsiColor = const Color(0xffC9B885),
    this.defaultTextColor = const Color(0xff60738E),
    this.nowPriceColor = const Color(0xffC9B885),
    this.depthBuyColor = const Color(0xff60A893),
    this.depthSellColor = const Color(0xffC15866),
    this.selectBorderColor = const Color(0xff6C7A86),
    this.selectFillColor = const Color(0xff0D1722),
  });
  final Color kLineColor;
  final Color lineFillColor;
  final Color ma5Color;
  final Color ma10Color;
  final Color ma30Color;
  final Color upColor;
  final Color dnColor;
  final Color volColor;
  final Color macdColor;
  final Color difColor;
  final Color deaColor;
  final Color kColor;
  final Color dColor;
  final Color jColor;
  final Color rsiColor;
  final Color defaultTextColor;
  final Color nowPriceColor;
  //深度颜色
  final Color depthBuyColor;
  final Color depthSellColor;
  //选中后显示值边框颜色
  final Color selectBorderColor;

  //选中后显示值背景的填充颜色
  final Color selectFillColor;

  @override
  Color getMAColor(int index) {
    Color maColor = ma5Color;
    switch (index % 3) {
      case 0:
        maColor = ma5Color;
        break;
      case 1:
        maColor = ma10Color;
        break;
      case 2:
        maColor = ma30Color;
        break;
    }
    return maColor;
  }

  ChartColors copyWith({
    Color? kLineColor,
    Color? lineFillColor,
    Color? ma5Color,
    Color? ma10Color,
    Color? ma30Color,
    Color? upColor,
    Color? dnColor,
    Color? volColor,
    Color? macdColor,
    Color? difColor,
    Color? deaColor,
    Color? kColor,
    Color? dColor,
    Color? jColor,
    Color? rsiColor,
    Color? defaultTextColor,
    Color? nowPriceColor,
    Color? depthBuyColor,
    Color? depthSellColor,
    Color? selectBorderColor,
    Color? selectFillColor,
  }) =>
      CustomChartColors(
        kLineColor: kLineColor ?? this.kLineColor,
        lineFillColor: lineFillColor ?? this.lineFillColor,
        ma5Color: ma5Color ?? this.ma5Color,
        ma10Color: ma10Color ?? this.ma10Color,
        ma30Color: ma30Color ?? this.ma30Color,
        upColor: upColor ?? this.upColor,
        dnColor: dnColor ?? this.dnColor,
        volColor: volColor ?? this.volColor,
        macdColor: macdColor ?? this.macdColor,
        difColor: difColor ?? this.difColor,
        deaColor: deaColor ?? this.deaColor,
        kColor: kColor ?? this.kColor,
        dColor: dColor ?? this.dColor,
        jColor: jColor ?? this.jColor,
        rsiColor: rsiColor ?? this.rsiColor,
        defaultTextColor: defaultTextColor ?? this.defaultTextColor,
        nowPriceColor: nowPriceColor ?? this.nowPriceColor,
        depthBuyColor: depthBuyColor ?? this.depthBuyColor,
        depthSellColor: depthSellColor ?? this.depthSellColor,
        selectBorderColor: selectBorderColor ?? this.selectBorderColor,
        selectFillColor: selectFillColor ?? this.selectFillColor,
      );
}
