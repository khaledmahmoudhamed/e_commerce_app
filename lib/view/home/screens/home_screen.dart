import 'package:e_commerce_app/core/reusable_widgets/reusable_text_form_field.dart';
import 'package:e_commerce_app/view/home/widgets/failed_load_product_screen.dart';
import 'package:e_commerce_app/view/home/widgets/home_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/product_cubit/product_cubit.dart';
import '../../../controller/product_cubit/product_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: ReusableTextFormField(
              obscureText: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: "Search products...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ProductCubit>().filteredProducts("");
                  controller.clear();
                },
                icon: Icon(Icons.clear, size: 25.sp, color: Colors.white),
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 18.sp),
              controller: controller,
              onChanged: (val) {
                context.read<ProductCubit>().filteredProducts(val);
              },
            ),
          ),
        ),
      ),

      body: BlocListener<ProductCubit, ProductState>(
        listenWhen: (previous, current) =>
            previous is FailedProductState && current is SuccessProductState,
        listener: (BuildContext context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Back Online!"),
              backgroundColor: Colors.green,
            ),
          );
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (BuildContext context, state) {
            if (state is LoadingProducts) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SuccessProductState) {
              final products = state.productsList;
              return products.isEmpty
                  ? Center(
                      child: Text(
                        "No Results",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  : ProductCard(
                      products: products,
                      onPressed: (product) {
                        context.read<ProductCubit>().toggleFavoriteItem(
                          product.id,
                        );
                      },
                    );
            } else if (state is FailedProductState) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ProductCubit>().getProducts();
                },
                child: FailedLoadProductScreen(
                  onPressed: () async {
                    await context.read<ProductCubit>().getProducts();
                  },
                  icon: state.errorModel.icon!,
                  text: state.errorModel.errorMessage,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
