import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../controller/cart_cubit/cart_cubit.dart';
import '../../controller/cart_cubit/cart_state.dart';

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
          width: 11.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.black,
                  size: 18.sp,
                ),
              ),
              Positioned(
                left: 1.w,
                top: 0.4.h,
                child: Text(
                  state.cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
