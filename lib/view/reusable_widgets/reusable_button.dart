import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.alignment,
    this.containerColor,
    this.padding,
    this.radius = 15,
    this.fontSize,
    this.fontWeight,
    this.margin,
  });
  final void Function()? onTap;
  final Widget text;
  final double? width;
  final Alignment? alignment;
  final Color? containerColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        alignment: alignment,
        width: width,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: padding,
        child: text,
      ),
    );
  }
}
