import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 0.1.h, color: Colors.black54),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            "or",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
        ),
        Expanded(
          child: Divider(thickness: 0.1.h, color: Colors.black54),
        ),
      ],
    );
  }
}
