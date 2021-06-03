import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeShortcutGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        // height: 140,
        color: Theme.of(context).backgroundColor,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: List.filled(10, 0, growable: true)
              .map(
                (i) => InkWell(
                  child: Container(
                    height: 72.0,
                    width: Get.width / 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_emotions),
                        Text('LeBei'),
                      ],
                    ),
                  ),
                  onTap: () => Get.snackbar(
                    'Common.Text.Tips'.tr,
                    'TODO',
                    duration: Duration(milliseconds: 2000),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent.withOpacity(.2),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
