import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/commons/ccxt/controllers/exchange_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class GeneralView extends GetView<SettingsController> {
  final ExchangeController exchangeController = Get.find<ExchangeController>();
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
                      Text('GeneralPage.Currency'.tr),
                      Obx(
                        () => Text(
                          '${controller.currency.value}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: () => Get.toNamed('/settings/general/currency'),
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
                Obx(
                  () => SwitchListTile(
                    title: Text('GeneralPage.Wakelock'.tr),
                    value: controller.wakelock.value,
                    onChanged: controller.onSwitchWakelock,
                  ),
                ),
                Divider(
                  height: 1.0,
                  indent: 16.0,
                ),
                Obx(
                  () => ListTile(
                    title: Text('GeneralPage.AutoRefresh'.tr),
                    subtitle: Slider(
                      value: controller.autoRefresh.value,
                      onChanged: controller.onChangeAutoRefresh,
                      min: 0.0,
                      max: 300.0,
                      divisions: 10,
                    ),
                    trailing: Text(controller.autoRefresh.value.isEqual(0)
                        ? 'GeneralPage.AutoRefresh.stopped'.tr
                        : '${controller.autoRefresh.value.round()}'),
                  ),
                ),
                Divider(
                  height: 1.0,
                  indent: 16.0,
                ),
                ListTile(
                  title: Text('GeneralPage.Reset'.tr),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: controller.resetAppDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
