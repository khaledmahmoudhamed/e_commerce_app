import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/reusable_widgets/reusable_button.dart';

class FacebookAndGoogleAuth extends StatelessWidget {
  const FacebookAndGoogleAuth({super.key, this.facebookFun, this.googleFun});
  final void Function()? facebookFun;
  final void Function()? googleFun;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ReusableButton(
          onTap: facebookFun,
          alignment: Alignment.center,
          width: 40.w,
          containerColor: Color(0xffD2F8FE),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("assets/facebook.svg", height: 3.5.h),
              Text(
                "Facebook",
                style: TextStyle(fontSize: 18.sp, color: Colors.black),
              ),
            ],
          ),
        ),
        ReusableButton(
          onTap: googleFun,
          alignment: Alignment.center,
          width: 40.w,
          containerColor: Color(0xffD2F8FE),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("assets/google.svg", height: 3.5.h),
              Text(
                "Google",
                style: TextStyle(fontSize: 18.sp, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
