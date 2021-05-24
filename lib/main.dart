import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lebei_exchange/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await SpUtil.getInstance();

  runApp(App());

  // 自定义报错页面
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint(flutterErrorDetails.toString());
    return Container(
      child: Center(
        child: new Text("App错误，快去反馈给作者!"),
      ),
    );
  };

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

// class MyApp extends StatelessWidget {
//   final Store<AppState> store = new Store(
//     appReducer,
//     initialState: AppState.initialState(),
//     middleware: []
//       ..add(
//         checkExchangeIdMiddleware,
//       )
//       ..add(
//         epicMiddleware,
//       )
//       ..add(
//         loggerMiddleware,
//       ),
//   );

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StoreProvider(
//       store: store,
//       child: App(),
//     );
//   }
// }
