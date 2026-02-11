import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/view/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../widgets/product_details/add_to_card_button.dart';
import '../widgets/product_details/extras_product_details.dart';
import '../widgets/product_details/product_details_card.dart';
import '../widgets/product_details/product_header_details.dart';
import '../widgets/product_details/product_details_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;
  final bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (BuildContext context, productState) {
          ProductModel currentProduct = product;
          if (productState is SuccessProductState) {
            currentProduct = productState.productsList.firstWhere(
              (element) => element.id == product.id,
              orElse: () => product,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ProductHeaderDetailsWidget(
                  product: product,
                  onPressed: () {
                    context.read<ProductCubit>().toggleFavoriteItem(product);
                  },
                  icon: currentProduct.isFavorite
                      ? Icon(Icons.favorite, color: Colors.red, size: 18.sp.sp)
                      : Icon(Icons.favorite_border, size: 18.sp),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailsText(product: product),
                      SizedBox(height: 3.h),
                      ProductDetailsCard(
                        product: currentProduct,
                        quantity: currentProduct.quantity,
                        increment: () {
                          context.read<ProductCubit>().changeQuantity(
                            currentProduct.id,
                            true,
                          );
                        },
                        decrement: () {
                          context.read<ProductCubit>().changeQuantity(
                            currentProduct.id,
                            false,
                          );
                        },
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Extras",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      ExtrasProductDetails(product: product),
                      AddToCardButton(
                        quantity: currentProduct.quantity,
                        product: currentProduct,
                        onTap: () async {
                          if (currentProduct.quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text(
                                  textAlign: TextAlign.center,
                                  "Quantity must more than 0",
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          } else {
                            context.read<CartCubit>().repo.toggleInCart(
                              currentProduct.id,
                              true,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                persist: false,
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.purple,
                                content: Text(
                                  "${currentProduct.title} added to cart!",
                                ),
                              ),
                            );
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
