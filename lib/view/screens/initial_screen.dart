import 'package:e_commerce_app/cubit/navigation_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/view/screens/cart_screen.dart';
import 'package:e_commerce_app/view/screens/favorite_screen.dart';
import 'package:e_commerce_app/view/screens/home_screen.dart';
import 'package:e_commerce_app/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_nav_bar.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (BuildContext context, currentIndex) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<NavigationCubit>().updateIndex(index);
            },
          ),
          body: screens[currentIndex],
        );
      },
    );
  }
}
