import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:ticket_ifma/core/utils/links.dart';

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
