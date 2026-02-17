import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardNumber; // Pass the number here
  const CreditCardWidget({super.key, required this.cardNumber});

  Widget _buildNumberBloc(String bloc) {
    return Text(
      bloc,
      style: TextStyle(
        fontSize: 17.sp,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 2,
        fontFamily: 'Courier',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String obscureCardText(String number) {
    String text = number.replaceAll(" ", "");
    String full16 = text.padRight(16, "X");
    String masked = "";
    for (int i = 0; i < 16; i++) {
      if (i > 1 && i < 12) {
        masked += "X";
      } else {
        masked += full16[i];
      }
    }

    return masked;
  }

  @override
  Widget build(BuildContext context) {
    String fullNumber = obscureCardText(cardNumber);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      height: 25.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: const Color(0xff0867d2), // Blue card background
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Image.network(
              //   "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png",
              //   width: 12.w,
              //   height: 6.h,
              // ),
              CachedNetworkImage(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 12.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 4.h,
            width: 12.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[200]!, Colors.amber[600]!],
              ),
              borderRadius: BorderRadius.circular(8.sp),
            ),
          ),
          SizedBox(height: 1.h),
          // Displaying the number in blocks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNumberBloc(fullNumber.substring(0, 4)),
              _buildNumberBloc(fullNumber.substring(4, 8)),
              _buildNumberBloc(fullNumber.substring(8, 12)),
              _buildNumberBloc(fullNumber.substring(12, 16)),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MARILYN SMITH",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              Row(
                children: [
                  Text(
                    "Expiry Dare",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "9/26",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
