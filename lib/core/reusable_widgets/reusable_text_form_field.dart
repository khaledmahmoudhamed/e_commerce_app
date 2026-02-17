import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.textStyle,
    this.fillColor,
    this.filled,
    this.prefixIcon,
    this.suffixIcon,
    this.errorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.border,
    this.validator,
    this.keyboardType,
    required this.obscureText,
    this.hintStyle,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool? filled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: textStyle,

      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintStyle: hintStyle,
        hintText: hintText,
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
      ),
      onChanged: onChanged,
    );
  }
}
