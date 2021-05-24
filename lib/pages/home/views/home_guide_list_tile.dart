import 'package:flutter/material.dart';

class HomeGuideListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: ListTile(
          leading: Container(
            width: 48,
            child: Center(
              child: Icon(Icons.emoji_emotions),
            ),
          ),
          title: Text('快捷买币'),
          subtitle: Text('支持BTC、USDT、ETH等'),
          trailing: Icon(
            Icons.chevron_right,
            color: Theme.of(context).unselectedWidgetColor,
          ),
        ),
      ),
    );
  }
}
