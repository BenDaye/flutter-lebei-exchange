import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends InterceptorsWrapper {
  final Dio dio;

  NetworkInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      return handler.reject(
        DioError(
          requestOptions: options,
          response: null,
          type: DioErrorType.connectTimeout,
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
