import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/web_services.dart';
import 'package:e_commerce_app/cubit/auth/auth_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/repository/app_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => WebServices(dio: getIt()));
  getIt.registerLazySingleton(() => AppRepo(webServices: getIt()));
  getIt.registerLazySingleton(() => ProductCubit(repo: getIt()));
  getIt.registerLazySingleton(() => CartCubit(repo: getIt()));
  getIt.registerLazySingleton(() => AuthCubit(repo: getIt()));
}
