import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/reusable_widgets/reusable_button.dart';
import '../../../cubit/cart_cubit/cart_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (BuildContext context, state) {
          if (state is SuccessProductState) {
            final favoriteItems = state.productsList
                .where((product) => product.isFavorite)
                .toList();
            if (favoriteItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/no data2.jpg'),
                    Text(
                      "No Favorites Yet",
                      style: TextStyle(fontSize: 20.sp, color: Colors.black54),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                child: Column(
                  children: [
                    Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: favoriteItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 9 / 14,
                          crossAxisSpacing: 1.w,
                          mainAxisSpacing: 1.h,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(
                                20.sp,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                  favoriteItems[index].thumbnail,
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              maxLines: 2,
                                              favoriteItems[index].title,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<ProductCubit>()
                                                  .toggleFavoriteItem(
                                                    favoriteItems[index],
                                                  );
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 17.sp,
                                              child: Icon(
                                                favoriteItems[index].isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      Text("\$${favoriteItems[index].price}"),
                                    ],
                                  ),
                                ),
                                ReusableButton(
                                  onTap: () {
                                    context.read<CartCubit>().isInCart(
                                      favoriteItems[index].id,
                                      true,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        persist: false,
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.black54,
                                        content: Text(
                                          textAlign: TextAlign.center,
                                          "${favoriteItems[index].title} added to cart!",
                                        ),
                                      ),
                                    );
                                  },
                                  radius: 12.sp,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  containerColor: Colors.orange,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_rounded,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Add",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
