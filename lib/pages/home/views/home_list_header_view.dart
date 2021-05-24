import 'package:flutter/material.dart';

class HomeListHeaderView extends StatelessWidget {
  final Key? key;
  final String? first;
  final String? middle;
  final String? last;
  final Widget? custom;

  HomeListHeaderView({
    this.key,
    this.first,
    this.middle,
    this.last,
    this.custom,
  });

  @override
  Widget build(BuildContext context) {
    if (this.custom != null) return this.custom!;

    return Container(
      color: Theme.of(context).bottomAppBarColor,
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
                Text(
                  '${this.first}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '${this.middle}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 104.0,
            child: Text(
              '${this.last}',
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
