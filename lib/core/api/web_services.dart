import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_interceptor.dart';
import 'package:e_commerce_app/core/api/api_services.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/exceptions/server_exceptions.dart';

import '../../models/products/product_model.dart';

class WebServices extends ApiServices {
  final Dio dio;
  WebServices({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        requestUrl: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Future<dynamic> getProducts(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.get(endPoint);
      return (response.data['products'] as List).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }

  @override
  Future<dynamic> post(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }

  @override
  Future<dynamic> getProfileData(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }
}
