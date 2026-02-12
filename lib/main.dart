import 'package:e_commerce_app/core/service_locator.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/view/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'cubit/navigation/navigation_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MyApp());
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
          ],
          child: MaterialApp(
            home: InitialScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
