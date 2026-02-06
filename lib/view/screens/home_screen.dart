import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_state.dart';
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
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final item = products[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: .5.h),
                  // height: 15.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: Colors.grey,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          // 2. Add rounded corners to the image too
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5.sp),
                          ),
                          child: Image.network(
                            item.thumbnail,
                            width: double.infinity,
                            fit: BoxFit
                                .cover, // 3. Make image fill the space nicely
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is FailedProductState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ProductCubit>().getProducts();
              },
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: state.icon),
                            Center(
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
