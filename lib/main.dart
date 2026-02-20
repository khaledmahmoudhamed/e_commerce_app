import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/cache/hive.dart';
import 'package:e_commerce_app/controller/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/api/api_interceptor.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'controller/auth/auth_cubit.dart';
import 'controller/cart_cubit/cart_cubit.dart';
import 'controller/navigation/navigation_cubit.dart';
import 'controller/product_cubit/product_cubit.dart';
import 'controller/toggle/toggle_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  // await CacheHelper.init();
  await HiveCache.init();
  await HiveCache.favoriteBoxFun('favoriteItems');
  await HiveCache.cartBoxFun('cartItems');
  await HiveCache.modeBoxFun('themeMode');
  await HiveCache.usersBoxFun('users');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final ThemeMode data = ThemeMode.dark;
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
            BlocProvider(create: (context) => ThemeCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (BuildContext context, themeMode) {
              return MaterialApp(
                theme: ThemeData.light(),
                themeMode: themeMode,
                darkTheme: ThemeData.dark(),
                navigatorKey: NavigationService.navigatorKey,
                home: SplashScreen(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }
}
