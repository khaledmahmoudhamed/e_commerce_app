import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExtrasProductDetails extends StatelessWidget {
  const ExtrasProductDetails({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Created At : ${product.metaData.createdAt}",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        Text(
          "Updated At : ${product.metaData.updatedAt}",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Center(
          child: Container(
            height: 18.h,
            width: 30.w,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Image.network(product.metaData.qrCode, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
