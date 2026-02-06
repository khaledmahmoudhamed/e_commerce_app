import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_state.dart';
import 'package:e_commerce_app/view/widgets/failed_load_product_screen.dart';
import 'package:e_commerce_app/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
              decoration: InputDecoration(
                hintText: "Search products...",
                fillColor: Colors.blueGrey,
                filled: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    context.read<ProductCubit>().filteredProducts("");
                  },
                  icon: Icon(Icons.clear, size: 25.sp),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
              ),
              onChanged: (val) {
                context.read<ProductCubit>().filteredProducts(val);
              },
            ),
          ),
        ),
      ),

      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (BuildContext context, state) {
          if (state is LoadingProducts) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SuccessProductState) {
            final products = state.productsList;
            return ProductCard(products: products);
          } else if (state is FailedProductState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ProductCubit>().getProducts();
              },
              child: FailedLoadProductScreen(
                icon: state.errorModel.icon!,
                text: state.errorModel.errorMessage,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
