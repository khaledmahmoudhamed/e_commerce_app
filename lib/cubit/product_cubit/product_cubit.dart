import 'dart:async';

import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repository/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.repo}) : super(InitialState()) {
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
      final filteredList = allProducts.where((element) {
        return element.title.contains(query.toLowerCase());
      }).toList();
      emit(SuccessProductState(productsList: filteredList));
    }
    currentQuery = query;
  }

  void toggleFavoriteItem(ProductModel productModel) {
    repo.toggleFavorite(productModel.id);

    ///Todo
    // using filteredProducts here with currentQuery to prevent appearing all products when you toggle favorite
    // but if you are going to use emit and use stream you can remove it
    // filteredProducts(currentQuery);
    // we should not use emit(SuccessProductState(productsList: List.from(allProducts)));
    // here because it return all products when i toggle favorite
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
    emit(SuccessProductState(productsList: resetProduct));
  }
}
