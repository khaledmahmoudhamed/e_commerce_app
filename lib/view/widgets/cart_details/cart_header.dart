import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../reusable_widgets/arrow_back_oulined_ios.dart';
import '../../reusable_widgets/check_out_cart_icon.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArrowBackIos(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        Text(
          "My Cart",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        CheckOutCartIcon(onPressed: () {}),
      ],
    );
  }
}
