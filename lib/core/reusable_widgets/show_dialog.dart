import 'package:e_commerce_app/core/reusable_widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShowDialogWidget {
  static void removingItemDialog({
    required BuildContext context,
    void Function()? onPressed,
    required String content,
    required String title,
    required String cancel,
    required String ok,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(textAlign: TextAlign.center, content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text(cancel),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(ok, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot tap outside to cancel
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xff0867d2), // Matches your card/button theme
        ),
      ),
    );
  }

  static void showSuccessDialog(
    BuildContext context,
    String total,
    void Function()? onTap,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 35.sp),
            SizedBox(height: 2.h),
            Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            Text(
              "Your transaction of $total was completed.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 3.h),

            ReusableButton(
              onTap: onTap,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              radius: 15.sp,
              child: Text(
                "Back To Cart",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              containerColor: Color(0xff0867d2),
            ),
          ],
        ),
      ),
    );
  }
}
