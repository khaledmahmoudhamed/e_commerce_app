import 'package:e_commerce_app/core/exceptions/exceptions_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductState extends Equatable {}

class InitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class LoadingProducts extends ProductState {
  @override
  List<Object> get props => [];
}

class SuccessProductState extends ProductState {
  final List<ProductModel> productsList;

  SuccessProductState({required this.productsList});

  SuccessProductState copyWith({List<ProductModel>? productsList}) {
    return SuccessProductState(productsList: productsList ?? this.productsList);
  }

  @override
  List<Object?> get props => [productsList];
}

class FailedProductState extends ProductState {
  final ErrorModel errorModel;
  FailedProductState({required this.errorModel});
  @override
  List<Object?> get props => [errorModel];
}

class NavigationBarState extends ProductState {
  final int currentIndex;
  NavigationBarState({required this.currentIndex});
  @override
  List<Object?> get props => [currentIndex];
}
