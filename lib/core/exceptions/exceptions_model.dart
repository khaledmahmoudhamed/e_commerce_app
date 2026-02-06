import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ErrorModel extends Equatable {
  final String errorMessage;
  final Icon? icon;

  @override
  List<Object> get props => [errorMessage];
  const ErrorModel({required this.errorMessage, this.icon});
}
