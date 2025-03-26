import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ticket_ifma/core/utils/links.dart';

class DioClient extends DioForNative {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: Links.i.selectedLink,
            connectTimeout: Duration(seconds: 5),
            receiveTimeout: Duration(seconds: 60),
          ),
        );
}
