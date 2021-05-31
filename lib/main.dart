import 'dart:async';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lebei_exchange/app.dart';
import 'package:sentry/sentry.dart';

void main() async {
  runZonedGuarded(() async {
    await Sentry.init(
      (options) {
        options.dsn = 'https://2b34494145a64955bc3044187f059a16@o178592.ingest.sentry.io/5785031';
      },
    );

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    await SpUtil.getInstance();

    runApp(App());
  }, (exception, stackTrace) async {
    debugPrintStack(stackTrace: stackTrace);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
