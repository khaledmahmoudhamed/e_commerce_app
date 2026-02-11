import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../cubit/product_cubit/product_cubit.dart';

class TextFiledWidget extends StatelessWidget {
  const TextFiledWidget({
    super.key,
    required this.controller,
    required this.getFilteredProducts,
    required this.removeSearch,
  });
  final TextEditingController controller;
  final VoidCallback removeSearch;
  final void Function(String)? getFilteredProducts;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: "Search products...",
        fillColor: Colors.blueGrey,
        filled: true,
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: removeSearch,
          icon: Icon(Icons.clear, size: 25.sp),
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.sp)),
      ),
      onChanged: getFilteredProducts,
    );
  }
}
