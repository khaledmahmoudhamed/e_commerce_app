import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.asset,
    required this.authText,
    required this.subText,
  });

  final String asset;
  final String authText;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 14.h,
            width: 30.w,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: SvgPicture.asset(asset),
          ),
        ),
        Center(
          child: Text(
            authText,
            style: TextStyle(
              fontSize: 25.sp,
              fontFamily: "Courier",
              fontWeight: FontWeight.bold,
              color: Color(0xff425BAF),
            ),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          subText,
          style: TextStyle(fontSize: 16.sp, fontFamily: "Georgia"),
        ),
      ],
    );
  }
}
