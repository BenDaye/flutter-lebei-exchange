import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SymbolHelper {
  static String getTitleText(String symbol) {
    if (symbol.isEmpty) return '';
    String? marginString = new RegExp(r"[1-9]\d*[LS]").stringMatch(symbol);
    if (marginString == null) return symbol;
    String marginText = marginString.substring(marginString.length - 1) == 'L' ? '' : '-';
    String multipleString = marginString.substring(0, marginString.length - 1);
    return symbol.replaceAll(marginString, '*($marginText$multipleString)');
  }

  static bool isMargin(String symbol) {
    if (symbol.isEmpty) return false;
    return new RegExp(r"[1-9]\d*[LS]").hasMatch(symbol);
  }

  static String getSubtitleText(String symbol) {
    if (symbol.isEmpty) return '';
    String marginString = new RegExp(r"[1-9]\d*[LS]").stringMatch(symbol)!;
    String marginText = marginString.substring(marginString.length - 1) == 'L' ? '做多' : '做空';
    String multipleString = marginString.substring(0, marginString.length - 1);
    return '$multipleString倍$marginText';
  }

  static Widget getTitle(String symbol) {
    if (symbol.isEmpty) return Text('/');
    String titleText = getTitleText(symbol);
    if (!titleText.contains('/')) return Text(titleText);

    final titleTextArray = titleText.split('/');

    return RichText(
      text: TextSpan(
        text: titleTextArray.first,
        style: Get.context?.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: ' /${titleTextArray.last}',
            style: Get.context?.textTheme.caption,
          ),
        ],
      ),
      maxLines: 1,
    );
  }

  static Widget getSubtitle(String symbol) => isMargin(symbol)
      ? Text(
          getSubtitleText(symbol),
          style: Get.context?.textTheme.caption?.copyWith(color: Colors.red[700]),
        )
      : Container();

  static String getPercentageSymbol(num? percentage) => NumUtil.greaterThan((percentage ?? 0), 0) ? '+' : '';

  static Color getPercentageColor(List<Color> colors, num? percentage) => NumUtil.isZero(percentage ?? 0)
      ? colors[1]
      : NumUtil.greaterThan((percentage ?? 0), 0)
          ? colors.first
          : colors.last;
}
