import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../product_detials/screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.products,
    required this.onPressed,
  });
  final List<ProductModel> products;
  final Function(ProductModel) onPressed;
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
        return InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(product: products[index]),
              ),
              (route) => true,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: .5.h),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
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
                        child: CachedNetworkImage(
                          imageUrl: item.thumbnail,
                          width: double.infinity,
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
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                          ),
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
                              Icon(
                                Icons.star,
                                color: Color(0xfff5b342),
                                size: 20.sp,
                              ),
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
                    onPressed: () => onPressed(item),
                    icon: Icon(
                      item.isFavorite
                          ? Icons.favorite
                          : Icons
                                .favorite_border, // Use border icon for unselected
                      color: Colors.red,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
