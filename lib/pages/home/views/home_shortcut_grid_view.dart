import 'package:flutter/material.dart';

class HomeShortcutGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 176,
        color: Theme.of(context).backgroundColor,
        child: GridView.count(
          crossAxisCount: 5,
          children: List.filled(10, 0, growable: true)
              .map(
                (i) => Container(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_emotions),
                      Text('LeBei'),
                    ],
                  ),
                ),
              )
              .toList(),
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
