import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/balance/controllers/balances_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BalancesView extends GetView<BalancesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              var logger = Logger();
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
              if (Platform.isAndroid) {
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                logger.d(androidInfo.androidId);
              } else if (Platform.isIOS) {
                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                logger.d(iosInfo.identifierForVendor);
              } else {
                logger.wtf('wtf');
              }
            },
            child: Text('getDeviceInfo'),
          ),
        ),
      ),
    );
  }
}
