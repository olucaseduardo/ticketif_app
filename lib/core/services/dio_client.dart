import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;
  late Dio _dio;

  DioClient(this.baseUrl) {
    _dio = Dio()..options.baseUrl = baseUrl;
  }

  Future<dynamic> get(String uri) async {
    try {
      var response = await _dio.get(uri);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String uri, {data}) async {
    try {
      var response = await _dio.post(uri, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
