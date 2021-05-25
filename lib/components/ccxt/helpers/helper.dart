import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CcxtHelper {
  static String getSymbolTitleText(String symbol) {
    if (symbol.isEmpty) return '';
    String? marginString = getMarginString(symbol);
    if (marginString == null) return symbol;
    String marginText = marginString.substring(marginString.length - 1) == 'L' ? '' : '-';
    String multipleString = marginString.substring(0, marginString.length - 1);
    return symbol.replaceAll(marginString, '*($marginText$multipleString)');
  }

  static bool isMarginSymbol(String symbol) {
    if (symbol.isEmpty) return false;
    return new RegExp(r"[1-9]\d*[LS]").hasMatch(symbol);
  }

  static String? getMarginString(String symbol) => new RegExp(r"[1-9]\d*[LS]").stringMatch(symbol);

  static String getSymbolSubtitleText(String symbol) {
    if (symbol.isEmpty) return '';
    String? marginString = getMarginString(symbol);
    if (marginString == null) return '';
    String marginText = marginString.substring(marginString.length - 1) == 'L' ? '做多' : '做空';
    String multipleString = marginString.substring(0, marginString.length - 1);
    return '$multipleString倍$marginText';
  }

  static Widget getSymbolTitle(String symbol) {
    if (symbol.isEmpty) return Text('/');
    String titleText = getSymbolTitleText(symbol);
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

  static Widget getSymbolSubtitle(String symbol, List<Color> colors) => isMarginSymbol(symbol)
      ? Text(
          getSymbolSubtitleText(symbol),
          style: Get.context?.textTheme.caption?.copyWith(
            color: getMarginString(symbol)!.contains('L') ? colors.first : colors.last,
          ),
        )
      : Container();

  static String getPercentageSymbol(num? percentage) => NumUtil.greaterThan((percentage ?? 0), 0) ? '+' : '';

  static Color getPercentageColor(List<Color> colors, num? percentage) => NumUtil.isZero(percentage ?? 0)
      ? colors[1]
      : NumUtil.greaterThan((percentage ?? 0), 0)
          ? colors.first
          : colors.last;

  static Widget getPercentageButton(List<Color> colors, num? percentage) => ElevatedButton(
        onPressed: () => null,
        child: Text(
          '${getPercentageSymbol(percentage)}${(percentage ?? 0).toStringAsFixed(2)}%',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          primary: getPercentageColor(colors, percentage),
          elevation: 0,
        ),
      );

  static Widget getPercentageText(List<Color> colors, num? percentage) => Text(
        '${getPercentageSymbol(percentage)}${(percentage ?? 0).toStringAsFixed(2)}%',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: getPercentageColor(colors, percentage),
        ),
      );
}
