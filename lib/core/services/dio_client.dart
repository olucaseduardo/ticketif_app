import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:project_ifma_ticket/core/config/env.dart';
import 'package:project_ifma_ticket/core/services/interceptors/auth_interceptor.dart';

class DioClient extends DioForNative {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: Env.i['backend_base_url'] ??  '',
            connectTimeout: 5000,
            receiveTimeout: 60000,
          ),
        );
}
