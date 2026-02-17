import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.sp),
        topRight: Radius.circular(30.sp),
      ),
      child: Container(
        height: 10.h,
        decoration: const BoxDecoration(color: Colors.green),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey[50],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'widgets'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
        ),
      ),
    );
  }
}
