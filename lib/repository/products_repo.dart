import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/core/exceptions/server_exceptions.dart';
import 'package:e_commerce_app/models/product_model.dart';

class ProductsRepo {
  final WebServices webServices;
  ProductsRepo({required this.webServices});
  Future<Either<ErrorModel, List<ProductModel>>> getProducts() async {
    try {
      final response = await webServices.getProducts(EndPoints.getProducts);
      return Right(response);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
