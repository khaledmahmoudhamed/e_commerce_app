import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/cache/hive.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/server_exceptions.dart';
import 'package:e_commerce_app/models/auth/sign_in_model.dart';
import 'package:e_commerce_app/models/auth/sign_up_model.dart';
import 'package:e_commerce_app/models/products/product_model.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class AppRepo {
  final WebServices webServices;
  AppRepo({required this.webServices});

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  final _productController = StreamController<List<ProductModel>>.broadcast();
  Stream<List<ProductModel>> get productController => _productController.stream;

  void setProducts(List<ProductModel> newProducts) {
    _products = newProducts;
    _productController.add(_products);
  }

  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final response = await webServices.get(EndPoints.getProducts);
      final data = (response.data['products'] as List).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  void updateCartQuantity(int productId, bool isIncrement) {
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
    final cartList = _products
        .where((p) => p.isInCart)
        .map((e) => e.toJson())
        .toList();
    HiveCache.cartBox?.put(ApiKey.cart, cartList);
  }

  void toggleFavorite(int productId) async {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );

      final favorites = _products
          .where((p) => p.isFavorite)
          .map((e) => e.toJson())
          .toList();

      await HiveCache.favBox?.put(ApiKey.favorite, favorites);
      _productController.add(List.from(_products)); // Notify everyone!
    }
  }

  void toggleInCart(int productId, bool isInCart) {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(isInCart: isInCart);
      final cachedCart = _products
          .where((p) => p.isInCart)
          .map((e) => e.toJson())
          .toList();
      HiveCache.cartBox?.put(ApiKey.cart, cachedCart);
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
      // CacheHelper().saveData(key: ApiKey.accessToken, value: user.accessToken);
      HiveCache.users?.put(ApiKey.accessToken, user.accessToken);
      // CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      HiveCache.users?.put(ApiKey.id, decodedToken[ApiKey.id]);
      return right(user);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> getUserData() async {
    try {
      final response = await webServices.get(EndPoints.getCurrentUser);
      return right(SignInModel.fromJson(response.data));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  void loadDataFromHive() {
    final cachedFav =
        HiveCache.favBox?.get(ApiKey.favorite, defaultValue: []) ?? [];
    final favIds = cachedFav.map((e) => e['id'] as int).toList();
    final cartCache =
        HiveCache.cartBox?.get(ApiKey.cart, defaultValue: []) ?? [];

    for (var product in _products) {
      if (favIds.contains(product.id)) product.isFavorite = true;
      var cartItems = cartCache.firstWhere(
        (e) => e['id'] == product.id,
        orElse: () => null,
      );
      if (cartItems != null) {
        product.isInCart = true;
        product.quantity = cartItems[ApiKey.quantity];
      }
    }
    _productController.add(List.from(_products));
  }
}
