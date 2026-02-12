import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class CartContainerWidget extends StatelessWidget {
  const CartContainerWidget({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.brand,
    required this.price,
  });
  final String thumbnail;
  final String title;
  final String brand;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 20.h,
          width: 35.w,
          child: Image.network(alignment: Alignment.topLeft, thumbnail),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  brand,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
