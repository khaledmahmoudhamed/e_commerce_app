import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HaveAccountSection extends StatelessWidget {
  const HaveAccountSection({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Do you have an account? ",
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: text,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
