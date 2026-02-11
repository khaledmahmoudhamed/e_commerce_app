import 'package:e_commerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<ProductModel> cartItems;
  const CartState({this.cartItems = const []});

  @override
  List<Object> get props => [cartItems];
}
