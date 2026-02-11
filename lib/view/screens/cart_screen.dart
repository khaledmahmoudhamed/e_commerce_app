import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/view/reusable_widgets/arrow_back_oulined_ios.dart';
import 'package:e_commerce_app/view/reusable_widgets/increment_decrement_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 17.w,
        leading: Navigator.of(context).canPop()
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: ArrowBackIos(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            : SizedBox(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("My Cart", style: TextStyle(fontSize: 25.sp)),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (BuildContext context, state) {
          return state.cartItems.isEmpty
              ? Center(
                  child: Text(
                    "Cart Is Empty",
                    style: TextStyle(fontSize: 25.sp),
                  ),
                )
              : ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Colors.grey,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                height: 20.h,
                                width: 35.w,
                                child: Image.network(
                                  alignment: Alignment.topLeft,
                                  state.cartItems[index].thumbnail,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        state.cartItems[index].title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        state.cartItems[index].brand,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "\$${state.cartItems[index].price}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 3.w,
                            bottom: 2.h,
                            child: IncrementDecrementButtons(
                              increment: () {
                                context.read<CartCubit>().changeQuantity(
                                  state.cartItems[index].id,
                                  true,
                                );
                              },
                              decrement: () {
                                if (state.cartItems[index].quantity == 1) {
                                  // 1. Show confirmation dialog when quantity is 1
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Remove from Cart"),
                                      content: const Text(
                                        textAlign: TextAlign.center,
                                        "Are you sure you want to remove this item?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            context,
                                          ), // Close dialog
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<CartCubit>()
                                                .changeQuantity(
                                                  state.cartItems[index].id,
                                                  false,
                                                );
                                            Navigator.pop(
                                              context,
                                            ); // Close dialog
                                          },
                                          child: const Text(
                                            "Remove",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  context.read<CartCubit>().changeQuantity(
                                    state.cartItems[index].id,
                                    false,
                                  );
                                }
                              },
                              counter: state.cartItems[index].quantity,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
