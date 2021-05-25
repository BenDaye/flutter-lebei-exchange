import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/assets/translations/en_US.dart';
import 'package:flutter_lebei_exchange/assets/translations/zh_CN.dart';
import 'package:get/get.dart';

class CustomTranslations extends Translations {
  static const List<Locale> supportLanguages = [
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh_CN,
        'en_US': en_US,
      };
}
