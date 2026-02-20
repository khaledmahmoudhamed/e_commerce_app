import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/reusable_widgets/increment_decrement_buttons.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.increment,
    required this.decrement,
  });
  final ProductModel product;
  final int quantity;
  final void Function()? increment;
  final void Function()? decrement;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Colors.black45,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Quantity",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20.sp, color: Color(0xfff5b342)),
                  SizedBox(width: 1.w),
                  Text(
                    product.rating.toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IncrementDecrementButtons(
                counter: quantity,
                increment: increment,
                decrement: decrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
