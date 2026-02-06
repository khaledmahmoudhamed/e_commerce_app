import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'exceptions_model.dart';

class ServerException implements Exception {
  ErrorModel errorModel;
  ServerException({required this.errorModel});
}

void handelDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "No Internet Connection",
          icon: Icon(Icons.wifi_off, color: Colors.red, size: 25.sp),
        ),
      );
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "Server is taking too long to respond",
          icon: Icon(Icons.timer_outlined, color: Colors.red, size: 25.sp),
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Bad Certificate"),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Request was cancelled"),
      );

    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "UnKnown Error"),
      );
    case DioExceptionType.badResponse:
      if (e.response != null) {
        throw ServerException(
          errorModel: ErrorModel(errorMessage: "Bad Response"),
        );
      } else {
        throw ServerException(
          errorModel: ErrorModel(
            errorMessage: "Received a bad response from server",
          ),
        );
      }
  }
}
