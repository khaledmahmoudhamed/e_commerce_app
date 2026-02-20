import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IncrementDecrementButtons extends StatelessWidget {
  const IncrementDecrementButtons({
    super.key,
    required this.increment,
    required this.decrement,
    required this.counter,
  });
  final void Function()? increment;
  final void Function()? decrement;
  final int counter;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.sp),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: decrement,
            child: CircleAvatar(
              radius: 15.sp,
              backgroundColor: Color(0xff17b6cf),
              child: Icon(Icons.remove, size: 18.sp),
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            counter.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 2.w),
          InkWell(
            onTap: increment,
            child: CircleAvatar(
              radius: 15.sp,
              backgroundColor: Color(0xffF57927),
              child: Icon(Icons.add, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
