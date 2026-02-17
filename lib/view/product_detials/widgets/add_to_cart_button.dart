import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/reusable_widgets/reusable_button.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.onTap,
    required this.product,
    required this.quantity,
  });
  final void Function()? onTap;
  final ProductModel product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return ReusableButton(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      alignment: Alignment.center,
      width: double.infinity,
      containerColor: Color(0xff702505),
      radius: 15.sp,
      child: Text(
        "Add to cart - \$${(quantity * product.price).toStringAsFixed(2)}",
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
      ),
    );
  }
}
