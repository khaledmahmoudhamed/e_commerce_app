import 'dart:async';

import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repository/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.repo}) : super(CartState()) {
    final initialCart = repo.products.where((p) => p.quantity > 0).toList();
    emit(CartState(cartItems: initialCart));
    subscription = repo.productsController.listen((updatedProducts) {
      final cartItems = updatedProducts
          .where((product) => product.isInCart == true)
          .toList();
      emit(CartState(cartItems: cartItems));
    });
  }
  final ProductsRepo repo;
  StreamSubscription? subscription;
  void addToCart(ProductModel product, bool isInCart) {
    List<ProductModel> cartList = List.from(state.cartItems);
    final index = cartList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      cartList[index] = cartList[index].copyWith(
        quantity: cartList[index].quantity + product.quantity,
      );
    } else {
      cartList.add(product);
    }
  }

  void changeQuantity(int productId, bool isIncremented) {
    repo.updateCartQuantity(productId, isIncremented);
    // emit(CartState(cartItems: repo.products));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
