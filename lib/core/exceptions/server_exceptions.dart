import 'package:dio/dio.dart';

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
        errorModel: ErrorModel(errorMessage: "No Internet Connection"),
      );
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "Server is taking too long to respond",
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Request was cancelled"),
      );

    case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      if (e.response != null) {
        throw ServerException(
          errorModel: ErrorModel.fromJson(e.response!.data),
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
