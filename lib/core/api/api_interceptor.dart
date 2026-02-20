import 'package:dio/dio.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/cache/hive.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/view/authantications/screens/login.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final String? token = CacheHelper().getData(key: ApiKey.accessToken);
    final String? token = HiveCache.users?.get(ApiKey.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // CacheHelper().removeData(key: ApiKey.accessToken);
      // CacheHelper().removeData(key: ApiKey.id);
      HiveCache.users?.delete(ApiKey.accessToken);
      HiveCache.users?.delete(ApiKey.id);
      NavigationService.navigateToReplacement(Login());
    }
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateToReplacement(Widget screen) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
