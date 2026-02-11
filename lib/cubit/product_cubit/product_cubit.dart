import 'dart:async';

import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repository/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.repo}) : super(InitialState()) {
    subscription = repo.productsController.listen((updatedList) {
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

  final ProductsRepo repo;
  StreamSubscription? subscription;
  List<ProductModel> allProducts = [];
  String currentQuery = "";

  Future<dynamic> getProducts() async {
    emit(LoadingProducts());
    final response = await repo.getProducts();
    response.fold(
      (error) {
        emit(
          FailedProductState(
            errorModel: ErrorModel(
              errorMessage: error.errorMessage,
              icon: error.icon,
            ),
          ),
        );
      },
      (products) {
        allProducts = products;
        repo.setProducts(products);
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
    currentQuery = query;
  }

  /* void toggleFavoriteItem(ProductModel productModel) {
    if (state is SuccessProductState) {
      final updatedList = allProducts.map((product) {
        return product.id == productModel.id
            ? product.copyWith(isFavorite: !product.isFavorite)
            : product;
      }).toList();

      allProducts = updatedList;
      emit((state as SuccessProductState).copyWith(productsList: updatedList));
    }
    filteredProducts(currentQuery);
  }*/
  void toggleFavoriteItem(ProductModel productModel) {
    repo.toggleFavorite(productModel.id);
    filteredProducts(currentQuery);
  }

  void changeQuantity(int productId, bool isIncremented) {
    repo.updateCartQuantity(productId, isIncremented);
    emit(SuccessProductState(productsList: allProducts));
  }
}
