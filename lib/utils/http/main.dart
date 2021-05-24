import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_lebei_exchange/config/http.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/error.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/success.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/utils/http/interceptors/network.dart';
import 'package:get/get.dart' as GetX;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static BaseOptions _options = BaseOptions(
    receiveTimeout: HttpConfig.HTTP_RECEVE_TIMEOUT,
    baseUrl: HttpConfig.HOST,
    receiveDataWhenStatusError: false,
  );

  Dio _dio = Dio(_options);

  Http() {
    _dio.interceptors.add(NetworkInterceptor(_dio));
    _dio.interceptors.add(PrettyDioLogger(maxWidth: 180, responseBody: false));
  }

  Future<HttpResult<T>> request<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    Map<String, dynamic> _headers = HashMap<String, dynamic>();
    if (headers != null) _headers.addAll(headers);

    if (options == null) options = Options(method: 'GET');
    options.headers = _headers;

    try {
      Response result = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return onSuccess<T>(result);
    } on DioError catch (error) {
      final httpError = onError<T>(error);
      GetX.Get.showSnackbar(GetX.GetBar(
        title: 'Network Error',
        message: httpError.message,
        snackPosition: GetX.SnackPosition.BOTTOM,
      ));
      return httpError;
    }
  }
}

final Http http = Http();
