import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_lebei_exchange/assets/translations/en_US.dart';
import 'package:flutter_lebei_exchange/assets/translations/zh_CN.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static const Locale fallbackLocale = Locale('en', 'US');

  static const List<Locale> supportLanguages = <Locale>[
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'zh_CN': zh_CN,
        'en_US': en_US,
      };
}
