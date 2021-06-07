import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/utils/formatter/number.dart';

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
      ? NumberFormatter.UNKNOWN_NUMBER_TO_STRING
      : '${getPercentageSymbol(percentage)}${percentage.toStringAsFixed(2)}%';

  static Widget getPercentageButton(List<Color> colors, double percentage) => ElevatedButton(
        onPressed: () => null,
        child: Text(
          getPercentageString(percentage),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          primary: getPercentageColor(colors, percentage),
          elevation: 0,
        ),
      );

  static Widget getPercentageText(List<Color> colors, double percentage) => Text(
        getPercentageString(percentage),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: getPercentageColor(colors, percentage),
        ),
      );
}
