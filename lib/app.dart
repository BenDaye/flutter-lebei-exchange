import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/assets/theme.dart';
import 'package:flutter_lebei_exchange/assets/translations/main.dart';
import 'package:flutter_lebei_exchange/routes/pages.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Pages.INITIAL,
      getPages: Pages.routes,
      theme: CustomTheme.themeData(false, context),
      darkTheme: CustomTheme.themeData(true, context),
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
    );
  }
}
