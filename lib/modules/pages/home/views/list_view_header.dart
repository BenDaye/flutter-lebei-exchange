import 'package:flutter/material.dart';

class HomeListViewHeader extends StatelessWidget {
  final Key? key;
  final String? firstText;
  final String? middleText;
  final String? lastText;

  final Widget? first;
  final Widget? middle;
  final Widget? last;

  final Widget? custom;

  HomeListViewHeader({
    this.key,
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

  @override
  Widget build(BuildContext context) {
    if (this.custom != null) return this.custom!;

    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                first != null
                    ? first!
                    : Text(
                        '${this.firstText}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                middle != null
                    ? middle!
                    : Text(
                        '${this.middleText}',
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
                    '${this.lastText}',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.right,
                  ),
          ),
        ],
      ),
    );
  }
}
