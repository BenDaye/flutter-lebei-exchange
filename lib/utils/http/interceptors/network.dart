import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends InterceptorsWrapper {
  NetworkInterceptor(this.dio);
  final Dio dio;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      return handler.reject(
        DioError(
          requestOptions: options,
          type: DioErrorType.connectTimeout,
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
