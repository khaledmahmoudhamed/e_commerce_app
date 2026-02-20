import 'package:e_commerce_app/models/auth/sign_in_model.dart';
import 'package:e_commerce_app/models/auth/sign_up_model.dart';
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {}

class InitialLoginState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends AuthState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends AuthState {
  final SignInModel successModel;
  SuccessLoginState({required this.successModel});
  @override
  List<Object> get props => [successModel];
}

class FailedLoginState extends AuthState {
  final String error;
  FailedLoginState({required this.error});
  @override
  List<Object> get props => [error];
}

class LoadingRegisterState extends AuthState {
  @override
  List<Object> get props => [];
}

class SuccessRegisterState extends AuthState {
  final SignUpModel model;
  // final bool isHidden;

  SuccessRegisterState({required this.model});

  @override
  List<Object> get props => [model];
}

class FailedRegisterState extends AuthState {
  final String message;
  FailedRegisterState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingGetUserDataState extends AuthState {
  @override
  List<Object> get props => [];
}

class SuccessGetUserDataState extends AuthState {
  final SignInModel model;

  SuccessGetUserDataState({required this.model});

  @override
  List<Object> get props => [model];
}

class FailedGetUserDataState extends AuthState {
  final String message;
  FailedGetUserDataState({required this.message});
  @override
  List<Object> get props => [message];
}
