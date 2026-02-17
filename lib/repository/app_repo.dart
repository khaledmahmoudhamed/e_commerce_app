import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/core/exceptions/server_exceptions.dart';
import 'package:e_commerce_app/models/auth/sign_in_model.dart';
import 'package:e_commerce_app/models/auth/sign_up_model.dart';
import 'package:e_commerce_app/models/products/product_model.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class AppRepo {
  final WebServices webServices;

  AppRepo({required this.webServices});
  Future<Either<ErrorModel, List<ProductModel>>> getProducts() async {
    try {
      final response = await webServices.getProducts(EndPoints.getProducts);
      return Right(response);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  final _productController = StreamController<List<ProductModel>>.broadcast();
  Stream<List<ProductModel>> get productController => _productController.stream;
  void setProducts(List<ProductModel> newProducts) {
    _products = newProducts;
    _productController.add(_products);
  }

  void updateCartQuantity(int productId, bool isIncrement) {
    /// Todo ///
    // this code return indexes that int the list _products firstly there is no
    // products in the list (when you increment or decrement in the product details screen without
    // click add product to cart if you check _products[index].isInCart result will be false but after
    // click add to cart _products length become 1 and have index in _products[index].isInCart becomes true
    final index = _products.indexWhere((element) {
      return element.id == productId;
    });

    if (index != -1) {
      int newQuantity = isIncrement
          ? _products[index].quantity + 1
          : _products[index].quantity - 1;
      if (newQuantity < 0) newQuantity = 0;
      _products[index] = _products[index].copyWith(
        quantity: newQuantity,
        isInCart: newQuantity == 0 ? false : _products[index].isInCart,
      );
    }
    _productController.add(List.from(_products));
  }

  void toggleFavorite(int productId) {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );
      _productController.add(List.from(_products)); // Notify everyone!
    }
  }

  void toggleInCart(int productId, bool isInCart) {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(isInCart: isInCart);
      _productController.add(List.from(_products));
    }
  }

  Future<Either<String, SignUpModel>> register({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    try {
      final response = await webServices.post(
        EndPoints.register,
        data: {
          'email': email,
          'phone': phone,
          "password": password,
          "firstName": name,
        },
      );
      return right(SignUpModel.fromJson(response.data));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await webServices.post(
        EndPoints.login,
        data: {"username": userName, "password": password},
      );
      final user = SignInModel.fromJson(response.data);
      final decodedToken = JwtDecoder.decode(user.accessToken);
      CacheHelper().saveData(key: ApiKey.accessToken, value: user.accessToken);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return right(user);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> getUserData() async {
    try {
      final response = await webServices.getProfileData(
        EndPoints.getCurrentUser,
      );
      return right(SignInModel.fromJson(response.data));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
