import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/market_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/chart_style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/flutter_k_chart.dart';

class OhlcvChartView extends GetView<MarketViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 32,
          padding: const EdgeInsets.only(right: 0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      tabs: controller.klineTabs,
                      controller: controller.klineTabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.toggleShowKlineSetting(),
                    child: Obx(
                      () => Icon(
                        Icons.settings,
                        size: 16,
                        color: controller.showKlineSettings.isTrue
                            ? Theme.of(context).buttonColor
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              Divider(height: 1.0),
            ],
          ),
        ),
        Obx(
          () => Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 420,
                width: double.infinity,
                child: controller.period.value == 'depth'
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
                        isLine: false,
                        mainState: controller.mainSatte.value,
                        secondaryState: controller.secondaryState.value,
                      ),
              ),
              AnimatedSize(
                vsync: controller,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: controller.showKlineSettings.value
                      ? Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              ListTile(
                                dense: true,
                                title: Text('MarketPage.KChart.MainState'.tr),
                                subtitle: Wrap(
                                  // alignment: WrapAlignment.start,
                                  // runAlignment: WrapAlignment.center,
                                  // crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  children: MainState.values
                                      .map(
                                        (e) => ElevatedButton(
                                          onPressed: () => {controller.mainSatte.value = e},
                                          child: Text(e.toString().split('.').last),
                                          style: ElevatedButton.styleFrom(
                                            primary: controller.mainSatte.value == e
                                                ? Theme.of(context).buttonColor
                                                : Theme.of(context).disabledColor,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              ListTile(
                                dense: true,
                                title: Text('MarketPage.KChart.SecondaryState'.tr),
                                subtitle: Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  children: SecondaryState.values
                                      .map(
                                        (e) => ElevatedButton(
                                          onPressed: () => {controller.secondaryState.value = e},
                                          child: Text(e.toString().split('.').last),
                                          style: ElevatedButton.styleFrom(
                                            primary: controller.secondaryState.value == e
                                                ? Theme.of(context).buttonColor
                                                : Theme.of(context).disabledColor,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ],
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
