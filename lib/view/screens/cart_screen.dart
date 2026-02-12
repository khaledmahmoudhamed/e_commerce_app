import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/view/reusable_widgets/arrow_back_oulined_ios.dart';
import 'package:e_commerce_app/view/reusable_widgets/increment_decrement_buttons.dart';
import 'package:e_commerce_app/view/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../reusable_widgets/show_dialog.dart';
import '../widgets/cart_details/bottom_sheet_widget.dart';
import '../widgets/cart_details/cart_container_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, state) {
        final subTotal = state.cartItems.fold(0.0, (previsValue, element) {
          return previsValue + (element.price * element.quantity);
        });
        final delivery = subTotal * 3 / 100;
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
          body: state.cartItems.isEmpty
              ? Center(
                  child: Text(
                    "Cart Is Empty",
                    style: TextStyle(fontSize: 25.sp),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartItems.length,

                        itemBuilder: (context, index) {
                          final cartItems = state.cartItems[index];
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
                                CartContainerWidget(
                                  thumbnail: cartItems.thumbnail,
                                  title: cartItems.title,
                                  brand: cartItems.brand,
                                  price: cartItems.price,
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
                                      if (state.cartItems[index].quantity ==
                                          1) {
                                        ShowDialogWidget.removingItemDialog(
                                          context,
                                          () {
                                            {
                                              context
                                                  .read<CartCubit>()
                                                  .changeQuantity(
                                                    state.cartItems[index].id,
                                                    false,
                                                  );
                                              Navigator.pop(context);
                                            }
                                          },
                                          "Are you sure you want to remove this item?",
                                          "Remove from Cart",
                                        );
                                      } else {
                                        context
                                            .read<CartCubit>()
                                            .changeQuantity(
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
                      ),
                    ),
                    state.cartItems.isEmpty
                        ? SizedBox()
                        : BottomSheetWidget(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PaymentMethodScreen(),
                                ),
                              );
                            },
                            text: Text(
                              "Check Out",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                            subTotal: "\$${subTotal.toStringAsFixed(2)}",
                            delivery: "\$${delivery.toStringAsFixed(3)}",
                            total:
                                "\$${(subTotal + delivery).toStringAsFixed(2)}",
                            backGroundColor: Color(0xffF57927),
                          ),
                  ],
                ),
        );
      },
    );
  }
}
