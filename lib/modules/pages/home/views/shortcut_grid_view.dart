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
          children: List<int>.filled(10, 0, growable: true)
              .map(
                (int i) => InkWell(
                  onTap: () => Get.snackbar(
                    'Common.Text.Tips'.tr,
                    'TODO',
                    duration: const Duration(milliseconds: 2000),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent.withOpacity(.2),
                  ),
                  child: SizedBox(
                    height: 72.0,
                    width: Get.width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.emoji_emotions),
                        Text('LeBei'),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
