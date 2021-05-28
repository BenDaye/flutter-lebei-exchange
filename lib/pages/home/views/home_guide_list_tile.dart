import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGuideListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListTile(
          leading: Container(
            width: 48,
            child: Center(
              child: Icon(Icons.emoji_emotions),
            ),
          ),
          title: Text('HomeGuide.Title'.tr),
          subtitle: Text('HomeGuide.Subtitle'.tr),
          trailing: Icon(
            Icons.chevron_right,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
    );
  }
}
