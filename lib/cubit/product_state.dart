import 'package:e_commerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  @override
  List<Object?> get props => [productsList];
}

class FailedProductState extends ProductState {
  final String error;
  final Icon icon;
  FailedProductState({required this.error, required this.icon});
  @override
  List<Object?> get props => [error, icon];
}
