import 'package:dio/dio.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/models/response.dart' as HttpModel;

HttpResult<T> onError<T>(error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.cancel:
        return HttpResult<T>(0, 'cancel', false);
      case DioErrorType.connectTimeout:
        return HttpResult<T>(0, 'connectTimeout', false);
      case DioErrorType.sendTimeout:
        return HttpResult<T>(0, 'sendTimeout', false);
      case DioErrorType.receiveTimeout:
        return HttpResult<T>(0, 'receiveTimeout', false);
      case DioErrorType.response:
        try {
          if (error.response?.statusCode == 200) {
            HttpModel.Response<T> response = HttpModel.Response<T>.fromJson(error.response?.data);
            return HttpResult<T>(response.status, response.message, false);
          }

          return HttpResult<T>(error.response?.statusCode ?? 0, 'Response Error: Unknown', false);
        } on Exception catch (_) {
          return HttpResult<T>(0, 'unknown', false);
        }
      default:
        return HttpResult<T>(0, 'unknown', false);
    }
  }
  return HttpResult<T>(0, 'unknown', false);
}
