import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/reusable_widgets/increment_decrement_buttons.dart';
import 'cart_container_widget.dart';

class ListViewContent extends StatelessWidget {
  const ListViewContent({
    super.key,
    required this.title,
    required this.brand,
    required this.price,
    required this.thumbnail,
    this.increment,
    this.decrement,
    required this.quantity,
  });
  final String title;
  final String brand;
  final double price;
  final String thumbnail;
  final void Function()? increment;
  final void Function()? decrement;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Colors.grey,
      ),
      child: Stack(
        children: [
          CartContainerWidget(
            thumbnail: thumbnail,
            title: title,
            brand: brand,
            price: price,
          ),
          Positioned(
            right: 3.w,
            bottom: 2.h,
            child: IncrementDecrementButtons(
              increment: increment,
              decrement: decrement,
              counter: quantity,
            ),
          ),
        ],
      ),
    );
  }
}
