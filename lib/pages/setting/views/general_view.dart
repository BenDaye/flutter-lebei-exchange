import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class GeneralView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).bottomAppBarColor,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SettingsPage.General'.tr,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GeneralPage.Language'.tr),
                      Obx(
                        () => Text(
                          'Language.${controller.locale.value.toLanguageTag()}'.tr,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: () => Get.toNamed('/settings/general/language'),
                ),
                Divider(
                  height: 1.0,
                  indent: 16.0,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GeneralPage.Color'.tr),
                      Obx(
                        () => Text(
                          controller.advanceDeclineColorMode.value.toString().tr,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: () => {
                    Get.bottomSheet(
                      Container(
                        color: Theme.of(context).backgroundColor,
                        child: SafeArea(
                          child: Wrap(
                            children: AdvanceDeclineColorMode.values
                                .map(
                                  (e) => ListTile(
                                    title: Text(e.toString().tr),
                                    selected: controller.advanceDeclineColorMode.value == e,
                                    onTap: () {
                                      controller.onSwitchAdvanceDeclineColorMode(e);
                                      Get.back();
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    )
                  },
                ),
                Divider(
                  height: 1.0,
                  indent: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
