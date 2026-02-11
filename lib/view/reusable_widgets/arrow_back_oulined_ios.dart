import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ArrowBackIos extends StatelessWidget {
  const ArrowBackIos({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 1.w),
      alignment: Alignment.center,
      height: 10.h,
      width: 10.w,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back_ios)),
    );
  }
}
