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
            icon: Icon(Get.isDarkMode ? Icons.highlight_off : Icons.wb_sunny),
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
                leading: Icon(Icons.settings),
                title: Text('安全设置'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('通用设置'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('关于我们'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('分享应用'),
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
