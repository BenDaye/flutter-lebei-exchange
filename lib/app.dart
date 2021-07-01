import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets/theme.dart';
import 'assets/translations/main.dart';
import 'routes/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.INITIAL,
      getPages: Pages.routes,
      theme: CustomTheme.themeData(false, context),
      darkTheme: CustomTheme.themeData(true, context),
      // debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      title: 'LeBei Global',
      popGesture: true,
    );
  }
}
