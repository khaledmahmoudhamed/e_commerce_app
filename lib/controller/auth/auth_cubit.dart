import 'dart:async';

import 'package:e_commerce_app/repository/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppRepo repo;
  AuthCubit({required this.repo}) : super(InitialLoginState());
  Future<void> register({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    emit(LoadingRegisterState());
    final response = await repo.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
    response.fold(
      (error) {
        emit(FailedRegisterState(message: error));
      },
      (success) {
        emit(SuccessRegisterState(model: success));
      },
    );
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(LoadingLoginState());
    final response = await repo.login(userName: userName, password: password);
    response.fold(
      (error) {
        emit(FailedLoginState(error: error));
      },
      (success) {
        emit(SuccessLoginState(successModel: success));
      },
    );
  }

  Future<void> getUserData() async {
    emit(LoadingGetUserDataState());
    final response = await repo.getUserData();
    response.fold(
      (error) {
        emit(FailedGetUserDataState(message: error));
      },
      (success) {
        emit(SuccessGetUserDataState(model: success));
      },
    );
  }
}
