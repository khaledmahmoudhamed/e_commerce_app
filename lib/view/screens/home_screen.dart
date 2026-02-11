import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/view/screens/favorite_screen.dart';
import 'package:e_commerce_app/view/screens/product_details_screen.dart';
import 'package:e_commerce_app/view/widgets/failed_load_product_screen.dart';
import 'package:e_commerce_app/view/widgets/home_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../widgets/text_filed.dart';

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
            child: TextFiledWidget(
              controller: controller,
              getFilteredProducts: (val) {
                context.read<ProductCubit>().filteredProducts(val);
              },
              removeSearch: () {
                context.read<ProductCubit>().filteredProducts("");
                controller.clear();
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
            return state.productsList.isEmpty
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
                      context.read<ProductCubit>().toggleFavoriteItem(product);
                    },
                  );
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
