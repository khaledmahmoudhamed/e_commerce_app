import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddToCardButton extends StatelessWidget {
  const AddToCardButton({
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
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff702505),
          borderRadius: BorderRadius.circular(15.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Text(
          "Add to cart - \$${(quantity * product.price).toStringAsFixed(2)} ",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
    );
  }
}
