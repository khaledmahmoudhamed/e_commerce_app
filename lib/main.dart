import 'package:dio/dio.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/core/api/api_interceptor.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/service_locator.dart';
import 'package:e_commerce_app/cubit/auth/auth_cubit.dart';
import 'package:e_commerce_app/cubit/toggle/toggle_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/initial_screen.dart';
import 'package:e_commerce_app/splash_screen.dart';
import 'package:e_commerce_app/view/authantications/screens/login.dart';
import 'package:e_commerce_app/view/authantications/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'cubit/navigation/navigation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext p1, Orientation p2, ScreenType p3) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<ProductCubit>()..getProducts(),
            ),
            BlocProvider(create: (context) => NavigationCubit()),
            BlocProvider(create: (context) => getIt<CartCubit>()),
            BlocProvider(
              create: (context) => getIt<AuthCubit>()..getUserData(),
            ),
            BlocProvider(create: (context) => ToggleCubit()),
          ],
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
