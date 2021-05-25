import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_lebei_exchange/assets/translations/main.dart';

class LanguageView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'GeneralPage.Language'.tr,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text('Language.${CustomTranslations.supportLanguages[index].toLanguageTag()}'.tr),
                selected: controller.locale.value == CustomTranslations.supportLanguages[index],
                onTap: () => controller.onChangeLocale(CustomTranslations.supportLanguages[index]),
              ),
              itemCount: CustomTranslations.supportLanguages.length,
            ),
          ),
        ],
      ),
    );
  }
}
