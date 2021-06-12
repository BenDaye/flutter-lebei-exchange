import 'package:flutter/material.dart';

class HomeListViewHeader extends StatelessWidget {
  const HomeListViewHeader({
    this.firstText,
    this.middleText,
    this.lastText,
    this.first,
    this.middle,
    this.last,
    this.custom,
  })  : assert(!(first == null && firstText == null)),
        assert(!(middle == null && middleText == null)),
        assert(!(last == null && lastText == null));

  final String? firstText;
  final String? middleText;
  final String? lastText;

  final Widget? first;
  final Widget? middle;
  final Widget? last;

  final Widget? custom;

  @override
  Widget build(BuildContext context) {
    if (custom != null) return custom!;

    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (first != null)
                  first!
                else
                  Text(
                    firstText!,
                    style: Theme.of(context).textTheme.caption,
                  ),
                if (middle != null)
                  middle!
                else
                  Text(
                    middleText!,
                    style: Theme.of(context).textTheme.caption,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 110.0,
            child: last != null
                ? last!
                : Text(
                    lastText!,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.right,
                  ),
          ),
        ],
      ),
    );
  }
}
