import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // 12/16 is ~0.75, 0.7 gives more height for text
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 0.5.h,
      ),
      itemBuilder: (context, index) {
        final item = products[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: .5.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
            ],
            borderRadius: BorderRadius.circular(12.sp),
            color: Colors.grey[70], // Changed to white so text/icons pop
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.sp),
                      child: Image.network(
                        item.thumbnail,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                      textAlign: TextAlign.center,
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${products[index].price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20.sp),
                            Text(
                              "${products[index].rating}",
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 0.5.h,
                right: 1.w,
                child: IconButton(
                  onPressed: () {
                    // Handle favorite logic
                  },
                  icon: Icon(
                    Icons.favorite_border, // Use border icon for unselected
                    color: Colors.red,
                    size: 20.sp,
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

// itemBuilder: (context, index) {
// final item = products[index];
// return Container(
// alignment: Alignment.topCenter,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
// ],
// borderRadius: BorderRadius.circular(8.sp),
// color: Colors.grey,
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Padding(
// padding: EdgeInsetsGeometry.symmetric(
// horizontal: 1.w,
// vertical: 1.h,
// ),
// child: Icon(Icons.favorite),
// ),
// Expanded(
// child: ClipRRect(
// borderRadius: BorderRadius.vertical(
// top: Radius.circular(8.sp),
// bottom: Radius.circular(8.sp),
// ),
// child: Image.network(
// item.thumbnail,
// width: double.infinity,
// fit: BoxFit.cover, // Cover prevents the 171px overflow
// ),
// ),
// ),
// Text(
// textAlign: TextAlign.center,
// item.title,
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
// ),
// Padding(
// padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "\$${products[index].price}",
// style: TextStyle(
// fontSize: 17.sp,
// fontWeight: FontWeight.bold,
// ),
// ),
// Row(
// children: [
// Icon(Icons.star, color: Colors.yellow, size: 20.sp),
// Text(
// products[index].rating.toString(),
// style: TextStyle(
// fontSize: 17.sp,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
// );
// },
