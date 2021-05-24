import 'package:flutter_lebei_exchange/store/app.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

void loggerMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  Logger().i(action.toString());

  next(action);
}
