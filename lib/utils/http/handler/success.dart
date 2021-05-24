import 'package:dio/dio.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/error.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/utils/http/models/response.dart' as HttpModel;

HttpResult<T> onSuccess<T>(Response response) {
  HttpModel.Response<T> responseData = HttpModel.Response<T>.fromJson(response.data);
  switch (responseData.status) {
    case 1:
      return HttpResult<T>(1, 'success', true, data: responseData.data as T);
    default:
      return onError<T>(DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.response,
        error: responseData.message,
      ));
  }
}
