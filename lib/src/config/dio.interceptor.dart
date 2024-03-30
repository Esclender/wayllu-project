import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final String token;

  DioInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
    });

    options.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    return super.onRequest(options, handler);
  }
}
