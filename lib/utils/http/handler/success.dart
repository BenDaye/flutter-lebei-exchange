import 'package:dio/dio.dart';

import '../../../models/response.dart' as http_model;
import 'types.dart';

// ignore: always_specify_types
HttpResult<T> onSuccess<T>(Response response) {
  final http_model.Response<T> responseData = http_model.Response<T>.fromJson(response.data as Map<String, dynamic>);
  switch (responseData.status) {
    case 1:
      return HttpResult<T>(1, 'success', true, data: responseData.data as T);
    default:
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.response,
        error: responseData.message,
      );
  }
}
