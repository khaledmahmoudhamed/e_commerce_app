import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/cache/hive.dart';
import 'package:e_commerce_app/controller/product_cubit/product_state.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:e_commerce_app/repository/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.repo}) : super(InitialState()) {
    subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (!results.contains(ConnectivityResult.none)) {
        if (state is LoadingProducts || state is FailedProductState) {
          getProducts();
        }
      }
    });
    subscription = repo.productController.listen((updatedList) {
      allProducts = List.from(updatedList);
      if (currentQuery.isEmpty) {
        emit(SuccessProductState(productsList: allProducts));
      } else {
        filteredProducts(currentQuery);
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  final AppRepo repo;
  StreamSubscription? subscription;
  List<ProductModel> allProducts = [];
  String currentQuery = "";

  Future<dynamic> getProducts() async {
    emit(LoadingProducts());
    final response = await repo.getProducts();
    response.fold(
      (error) {
        emit(FailedProductState(errorModel: ErrorModel(errorMessage: error)));
      },
      (products) {
        allProducts = products;
        repo.setProducts(products);
        repo.loadDataFromHive();

        emit(SuccessProductState(productsList: products));
      },
    );
  }

  void filteredProducts(String query) {
    if (query.isEmpty) {
      emit(SuccessProductState(productsList: List.from(allProducts)));
    } else {
      final filteredList = allProducts.where((element) {
        return element.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(SuccessProductState(productsList: filteredList));
    }
    currentQuery = query;
  }

  void toggleFavoriteItem(int id) {
    repo.toggleFavorite(id);
    filteredProducts(currentQuery);
  }

  void changeQuantity(int productId, bool isIncremented) {
    repo.updateCartQuantity(productId, isIncremented);
    emit(SuccessProductState(productsList: allProducts));
  }

  void resetAllQuantitesAfterPayment() {
    final resetProduct = allProducts.map((e) {
      return e.copyWith(quantity: 0, isInCart: false);
    }).toList();
    repo.setProducts(resetProduct);
    emit(SuccessProductState(productsList: resetProduct));
  }
}
