import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:project_ifma_ticket/core/utils/links.dart';

class DioClient extends DioForNative {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: Links.i.selectedLink,
            connectTimeout: 5000,
            receiveTimeout: 60000,
          ),
        );
}
