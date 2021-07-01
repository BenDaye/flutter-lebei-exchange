import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/formatter/number.dart';

class PercentageHelper {
  static String getPercentageSymbol(double percentage) =>
      (percentage.isNaN || NumUtil.lessThan(percentage, 0)) ? '' : '+';

  static Color getPercentageColor(List<Color> colors, double percentage) =>
      (percentage.isNaN || NumUtil.isZero(percentage))
          ? colors[1]
          : NumUtil.greaterThan(percentage, 0)
              ? colors.first
              : colors.last;

  static String getPercentageString(double percentage) => percentage.isNaN
      ? NumberFormatter.unknownNumberToString
      : '${getPercentageSymbol(percentage)}${percentage.toStringAsFixed(2)}%';

  static Widget getPercentageButton(List<Color> colors, double percentage) => ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: getPercentageColor(colors, percentage),
          elevation: 0,
        ),
        child: Text(
          getPercentageString(percentage),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  static Widget getPercentageText(List<Color> colors, double percentage, {TextStyle? textStyle}) => Text(
        getPercentageString(percentage),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: getPercentageColor(colors, percentage),
        ).merge(textStyle),
      );

  static Widget getPercentageBadge(List<Color> colors, double percentage, {TextStyle? textStyle}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          color: getPercentageColor(colors, percentage).withOpacity(.2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          getPercentageString(percentage),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.context?.theme.textTheme.caption
              ?.copyWith(
                color: getPercentageColor(colors, percentage),
                fontWeight: FontWeight.bold,
              )
              .merge(textStyle),
        ),
      );
}
