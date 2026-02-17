import 'dart:async';
import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/repository/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.repo}) : super(CartState(cartItems: [])) {
    final initialCart = repo.products.where((p) => p.quantity > 0).toList();
    emit(CartState(cartItems: initialCart));
    subscription = repo.productController.listen((updatedProducts) {
      final cartItems = updatedProducts
          .where((product) => product.isInCart == true)
          .toList();
      emit(CartState(cartItems: cartItems));
    });
  }
  final AppRepo repo;
  StreamSubscription? subscription;

  void changeQuantity(int productId, bool isIncremented) {
    repo.updateCartQuantity(productId, isIncremented);
  }

  void isInCart(int productId, bool isInCart) {
    repo.toggleInCart(productId, isInCart);
  }

  void clearCart() {
    emit(CartState(cartItems: []));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
