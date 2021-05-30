import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/currency_view_controller.dart';
import 'package:flutter_lebei_exchange/pages/setting/controllers/settings_controller.dart';
import 'package:get/get.dart';

class CurrencyView extends GetView<CurrencyViewController> {
  final SettingsController settingsController = Get.find<SettingsController>();

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
              'GeneralPage.Currency'.tr,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: SafeArea(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(controller.codes[index].code),
                    selected: settingsController.currency.value == controller.codes[index].code,
                    onTap: () => settingsController.onChangeCurrency(controller.codes[index].code),
                  ),
                  itemCount: controller.codes.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
