import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<ProductModel> cartItems;
  const CartState({this.cartItems = const []});

  CartState copyWith({List<ProductModel>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }

  @override
  List<Object> get props => [cartItems];
}
