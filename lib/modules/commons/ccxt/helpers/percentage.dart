import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class PercentageHelper {
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
