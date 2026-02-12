import 'dart:async';

import 'package:dartz/dartz.dart';
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

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  // final _productsController = StreamController<List<ProductModel>>.broadcast();
  // Stream<List<ProductModel>> get productsController =>
  //     _productsController.stream;
  // void setProducts(List<ProductModel> newProducts) {
  //   _products = newProducts;
  //   _productsController.add(_products);
  // }

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
}
