import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../reusable_widgets/reusable_button.dart';
import '../../screens/payment_screen.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.subTotal,
    required this.delivery,
    required this.total,
    required this.text,
    this.onTap,
    required this.backGroundColor,
  });
  final String subTotal;
  final String delivery;
  final String total;
  final Widget text;
  final void Function()? onTap;
  final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.sp),
          topRight: Radius.circular(15.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SubTotal", style: TextStyle(fontSize: 18.sp)),
                Text(subTotal, style: TextStyle(fontSize: 18.sp)),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery", style: TextStyle(fontSize: 18.sp)),
                Text(delivery, style: TextStyle(fontSize: 18.sp)),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  total,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ReusableButton(
              onTap: onTap,
              text: text,
              containerColor: backGroundColor,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              width: double.infinity,
              alignment: Alignment.center,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
