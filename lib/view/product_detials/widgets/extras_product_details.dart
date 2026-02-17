import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/products/product_model.dart';
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
            child: CachedNetworkImage(
              imageUrl: product.metaData.qrCode,
              width: double.infinity,
              // height: 20.h,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 40.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
