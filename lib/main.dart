import 'dart:async';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lebei_exchange/app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sentry/sentry.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await Sentry.init(
      (SentryOptions options) {
        options.dsn = 'https://2b34494145a64955bc3044187f059a16@o178592.ingest.sentry.io/5785031';
      },
    );

    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        testDeviceIds: <String>['kGADSimulatorID'],
      ),
    );
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    await SpUtil.getInstance();

    runApp(const App());
  }, (Object exception, StackTrace stackTrace) async {
    debugPrintStack(stackTrace: stackTrace);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
