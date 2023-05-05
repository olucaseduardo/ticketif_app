import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final sp = await SharedPreferences.getInstance();
    // final accessToken = sp.getString('accessToken');

    // options.headers['Authorization'] = 'Bearer $accessToken';

    // handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      // GlobalContext.i.loginExpire();
      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}