import 'package:e_commerce_app/models/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsText extends StatefulWidget {
  const ProductDetailsText({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsText> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<ProductDetailsText> {
  final ValueNotifier<bool> isDescriptionExpanded = ValueNotifier<bool>(false);

  @override
  void dispose() {
    isDescriptionExpanded.dispose(); // Clean up memory
    super.dispose();
  }

  String _getTruncatedText(String text) {
    if (text.length <= 70) return text;
    return text.substring(0, (text.length / 2).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
        ),
        SizedBox(height: 2.h),
        ValueListenableBuilder<bool>(
          valueListenable: isDescriptionExpanded,
          builder: (context, isExpanded, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    isDescriptionExpanded.value = !isDescriptionExpanded.value;
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: isExpanded
                              ? widget.product.description
                              : _getTruncatedText(widget.product.description),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: isExpanded ? "Show Less" : " Read More",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationThickness: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
