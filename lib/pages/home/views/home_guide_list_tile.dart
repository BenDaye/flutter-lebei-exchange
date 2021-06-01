import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGuideListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
        onTap: () => Get.snackbar(
          'Tips',
          'TODO',
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orangeAccent.withOpacity(.2),
        ),
      ),
    );
  }
}
