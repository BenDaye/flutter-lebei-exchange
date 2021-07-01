import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sentry/sentry.dart';

import '../../config/http.dart';
import 'handler/error.dart';
import 'handler/success.dart';
import 'handler/types.dart';
import 'interceptors/network.dart';

class Http {
  Http() {
    _dio.interceptors.add(NetworkInterceptor(_dio));
    _dio.interceptors.add(PrettyDioLogger(maxWidth: 180, responseBody: false));
  }

  static final BaseOptions _options = BaseOptions(
    receiveTimeout: HttpConfig.httpReceveTimeout,
    baseUrl: HttpConfig.host,
    receiveDataWhenStatusError: false,
  );

  final Dio _dio = Dio(_options);

  Future<HttpResult<T>> request<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    Function(dynamic)? handleError,
  }) async {
    final Map<String, dynamic> _headers = HashMap<String, dynamic>();
    if (headers != null) _headers.addAll(headers);

    options ??= Options(method: 'GET');
    options.headers = _headers;

    try {
      // ignore: always_specify_types
      final Response result = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return onSuccess<T>(result);
    } on DioError catch (error) {
      final HttpResult<T> httpError = onError<T>(error);
      if (handleError == null) {
        getx.Get.showSnackbar(
          // ignore: always_specify_types
          getx.GetBar(
            title: 'NETWORK_ERROR',
            message: httpError.message.length > 128 ? '${httpError.message.substring(0, 128)}...' : httpError.message,
            snackPosition: getx.SnackPosition.TOP,
            snackStyle: getx.SnackStyle.GROUNDED,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        handleError(error);
      }

      return httpError;
    } catch (error) {
      Sentry.captureException(error);

      if (handleError == null) {
        getx.Get.showSnackbar(
          // ignore: always_specify_types
          getx.GetBar(
            title: 'UNEXPECTED_NETWORK_ERROR',
            message: error.toString().length > 128 ? '${error.toString().substring(0, 128)}...' : error.toString(),
            snackPosition: getx.SnackPosition.TOP,
            snackStyle: getx.SnackStyle.GROUNDED,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        handleError(error);
      }
      return onError<T>(error);
    }
  }
}

final Http http = Http();
