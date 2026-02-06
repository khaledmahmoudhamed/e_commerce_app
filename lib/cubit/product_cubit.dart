import 'package:e_commerce_app/cubit/product_state.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repository/products_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.api}) : super(InitialState());

  final ProductsRepo api;

  List<ProductModel> allProducts = [];
  Future<dynamic> getProducts() async {
    print("get products");
    emit(LoadingProducts());
    final response = await api.getProducts();
    response.fold(
      (error) {
        emit(
          FailedProductState(
            error: error,
            icon: Icon(Icons.wifi_off, size: 25.sp, color: Colors.red),
          ),
        );
      },
      (products) {
        allProducts = products;
        emit(SuccessProductState(productsList: products));
      },
    );
  }

  void filteredProducts(String query) {
    if (query.isEmpty) {
      emit(SuccessProductState(productsList: List.from(allProducts)));
    } else {
      final filteredList = allProducts.where((e) {
        return e.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(SuccessProductState(productsList: filteredList));
    }
  }
}
