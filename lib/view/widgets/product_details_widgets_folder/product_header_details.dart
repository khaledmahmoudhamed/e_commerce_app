import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/product_model.dart';
import '../../reusable_widgets/arrow_back_oulined_ios.dart';
import '../../reusable_widgets/check_out_cart_icon.dart';
import '../../screens/cart_screen.dart';

class ProductHeaderDetailsWidget extends StatelessWidget {
  const ProductHeaderDetailsWidget({
    super.key,
    required this.product,
    required this.onPressed,
    required this.icon,
  });
  final ProductModel product;
  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.sp),
              bottomRight: Radius.circular(25.sp),
            ),
          ),
          child: Image.network(product.thumbnail, fit: BoxFit.cover),
        ),
        Positioned(
          top: 1.5.h,
          left: 3.w,
          right: 3.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArrowBackIos(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CheckOutCartIcon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => CartScreen()),
                    (route) => true,
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          // bottom: 0.h,
          top: 26.4.h,
          right: 3.w,
          left: 5.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    child: Text(
                      product.brand,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsGeometry.only(left: 3.w),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    child: Text(
                      product.category,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: onPressed,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17.sp,
                  child: icon,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
