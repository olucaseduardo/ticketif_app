import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManagerUtil {
  final _stealPeriod = const Duration(minutes: 1);

  loadImageStudent(String url) async {
    final sp = await SharedPreferences.getInstance();
    final studentRegistration = sp.getString('matricula');

    if (studentRegistration == null) {
      return;
    }

    final cacheKey = "student_photo_$studentRegistration";
    await DefaultCacheManager().getSingleFile(
      url,
      key: cacheKey,
    );
  }

  clearImageStudent() async {
    final sp = await SharedPreferences.getInstance();
    final studentRegistration = sp.getString('matricula');

    if (studentRegistration == null) {
      return;
    }

    final cacheKey = "student_photo_$studentRegistration";

    var photoStudentCache =
        await DefaultCacheManager().getFileFromCache(cacheKey);

    if (photoStudentCache == null) {
      return;
    }

    try {
      await DefaultCacheManager().removeFile(cacheKey);
      return;
    } catch (e) {
      log("Error ao deleter cache de imagem", error: e);
    }
  }

  Future<bool> isImageUrlValid(String url) async {
    try {
      final response = await Dio().head(
        url,
        options: Options(
          receiveTimeout: 3000,
        ),
      );
      final contentType = response.headers['content-type']?.first;
      return contentType?.startsWith('image/') ?? false;
    } catch (e) {
      return false;
    }
  }
}