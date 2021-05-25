import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.mode_night : Icons.light_mode),
            onPressed: () => controller.onSwitchThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                title: Text('Hi, LeBeiGlobal'),
                subtitle: Text('yypsgdsg@163.com'),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.filled(4, 0, growable: true)
                      .map(
                        (i) => Expanded(
                          child: Container(
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
                        ),
                      )
                      .toList(),
                ),
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('SettingsPage.Security'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('SettingsPage.General'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: () => Get.toNamed('/settings/general'),
              ),
              ListTile(
                leading: Icon(Icons.menu_book),
                title: Text('SettingsPage.About'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.thumb_up),
                title: Text('SettingsPage.Share'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
