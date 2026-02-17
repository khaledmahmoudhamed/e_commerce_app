import 'package:e_commerce_app/cubit/navigation/navigation_cubit.dart';
import 'package:e_commerce_app/view/cart/screens/cart_screen.dart';
import 'package:e_commerce_app/view/favorite/screens/favorite_screen.dart';
import 'package:e_commerce_app/view/home/screens/home_screen.dart';
import 'package:e_commerce_app/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/home/widgets/bottom_nav_bar.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
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
