import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SymbolHelper {
  static String getSymbolTitleText(String symbol) {
    if (symbol.isEmpty) return '--';
    final String? marginString = getMarginString(symbol);
    if (marginString == null) return symbol;
    final String marginText = marginString.substring(marginString.length - 1) == 'L' ? '' : '-';
    final String multipleString = marginString.substring(0, marginString.length - 1);
    return symbol.replaceAll(marginString, '*($marginText$multipleString)');
  }

  static bool isMarginSymbol(String symbol) {
    if (symbol.isEmpty) return false;
    return RegExp(r'[1-9]\d*[LS]').hasMatch(symbol);
  }

  static String? getMarginString(String symbol) => RegExp(r'[1-9]\d*[LS]').stringMatch(symbol);

  static String getSymbolSubtitleText(String symbol) {
    if (symbol.isEmpty) return '';
    final String? marginString = getMarginString(symbol);
    if (marginString == null) return '';
    final String marginText = marginString.substring(marginString.length - 1) == 'L'
        ? 'MarginSymbolSubtitle.Long'.tr
        : 'MarginSymbolSubtitle.Short'.tr;
    final String multipleString = marginString.substring(0, marginString.length - 1);
    return multipleString + 'MarginSymbolSubtitle.Multiple'.tr + marginText;
  }

  static Widget getSymbolTitle(String symbol, {TextStyle? baseTextStyle, TextStyle? quoteTextStyle}) {
    if (symbol.isEmpty) return const Text('/');
    final String titleText = getSymbolTitleText(symbol);
    if (!titleText.contains('/')) return Text(titleText);

    final List<String> titleTextArray = titleText.split('/');

    return RichText(
      text: TextSpan(
        text: titleTextArray.first,
        style: baseTextStyle ?? Get.context?.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        children: <InlineSpan>[
          TextSpan(
            text: ' /${titleTextArray.last}',
            style: quoteTextStyle ?? Get.context?.textTheme.caption,
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
}
