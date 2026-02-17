import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/view/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CheckOutCartIcon extends StatelessWidget {
  const CheckOutCartIcon({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, state) {
        return Container(
          alignment: Alignment.center,
          height: 10.h,
          width: 10.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.shopping_cart_checkout),
              ),
              Positioned(
                child: Text(
                  state.cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
