import 'dart:math';

import 'package:e_commerce_app/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/view/credit_card/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/reusable_widgets/arrow_back_oulined_ios.dart';
import '../../core/reusable_widgets/show_dialog.dart';
import '../cart/widgets/bottom_sheet_widget.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
            title: const Text("Payment Method"),
            centerTitle: true,
            leadingWidth: 17.w,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: ArrowBackIos(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          bottomNavigationBar: BottomSheetWidget(
            onTap: () {
              if (formKey.currentState!.validate()) {
                ShowDialogWidget.showLoadingDialog(context);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  ShowDialogWidget.showSuccessDialog(
                    context,
                    (subTotal + delivery).toStringAsFixed(2),
                    () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context
                          .read<ProductCubit>()
                          .resetAllQuantitesAfterPayment();
                    },
                  );
                });
              }
            },

            backGroundColor: Color(0xff0867d2),
            text: Text(
              "Pay Now",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
            subTotal: "\$${subTotal.toStringAsFixed(2)}",
            delivery: "\$${delivery.toStringAsFixed(3)}",
            total: "\$${(subTotal + delivery).toStringAsFixed(2)}",
          ),
          body: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CreditCardWidget(cardNumber: controller.text),
                  SizedBox(height: 2.h),
                  TextFormField(
                    validator: (val) {
                      if (controller.text.isEmpty || val == null) {
                        return "required";
                      }
                      return null;
                    },
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    obscureText: true,
                    obscuringCharacter: "X",
                    maxLength: 16, // 16 digits + 3 spaces
                    decoration: InputDecoration(
                      hintText: "XXXX XXXX XXXX XXXX",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      prefixIcon: const Icon(Icons.credit_card),
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final items = state.cartItems[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "${index + 1}.${items.title}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "brand.${items.brand}",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              trailing: Text(
                                "\$${items.price}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
