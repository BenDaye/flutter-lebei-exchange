import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.mode_night : Icons.light_mode),
            onPressed: () => controller.onSwitchThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).bottomAppBarColor,
                child: const ListTile(
                  title: Text('Hi, LeBeiGlobal'),
                  subtitle: Text('yypsgdsg@163.com'),
                ),
              ),
              SizedBox(
                child: Row(
                  children: List<int>.filled(4, 0, growable: true)
                      .map(
                        (int i) => Expanded(
                          child: SizedBox(
                            height: 80.0,
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
              ListTile(
                leading: const Icon(Icons.security),
                title: Text('SettingsPage.Security'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
                enabled: false,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text('SettingsPage.General'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: () => Get.toNamed('/settings/general'),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: Text('SettingsPage.About'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
                enabled: false,
              ),
              ListTile(
                leading: const Icon(Icons.thumb_up),
                title: Text('SettingsPage.Share'.tr),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
