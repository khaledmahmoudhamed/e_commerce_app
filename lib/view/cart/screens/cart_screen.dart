import 'package:e_commerce_app/view/credit_card/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/cart_cubit/cart_cubit.dart';
import '../../../controller/cart_cubit/cart_state.dart';
import '../../../core/reusable_widgets/arrow_back_oulined_ios.dart';
import '../../../core/reusable_widgets/show_dialog.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/list_view_content.dart';

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
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Colors.white,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/empty-cart.svg",
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        color: Colors.red,
                      ),
                      SizedBox(height: 3.h),
                      Text("Cart Is Empty", style: TextStyle(fontSize: 20.sp)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItems = state.cartItems[index];
                          return ListViewContent(
                            title: cartItems.title,
                            brand: cartItems.brand,
                            price: cartItems.price,
                            thumbnail: cartItems.thumbnail,
                            quantity: cartItems.quantity,
                            increment: () {
                              context.read<CartCubit>().changeQuantity(
                                state.cartItems[index].id,
                                true,
                              );
                            },
                            decrement: () {
                              if (state.cartItems[index].quantity == 1) {
                                ShowDialogWidget.removingItemDialog(
                                  context: context,
                                  onPressed: () {
                                    {
                                      context.read<CartCubit>().changeQuantity(
                                        state.cartItems[index].id,
                                        false,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  content:
                                      "Are you sure you want to remove this item?",
                                  title: "Remove from Cart",
                                  cancel: "Cancel",
                                  ok: "Remove",
                                );
                              } else {
                                context.read<CartCubit>().changeQuantity(
                                  state.cartItems[index].id,
                                  false,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    state.cartItems.isEmpty
                        ? SizedBox()
                        : BottomSheetWidget(
                            onTap: () {
                              final hasNoQuantity = state.cartItems.any(
                                (element) => element.quantity == 0,
                              );
                              if (hasNoQuantity) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      textAlign: TextAlign.center,
                                      "Please update or remove items with 0 quantity before checking out.",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PaymentMethodScreen(),
                                  ),
                                );
                              }
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
