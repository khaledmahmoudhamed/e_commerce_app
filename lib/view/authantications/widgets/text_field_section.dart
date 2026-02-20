import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/toggle/toggle_cubit.dart';
import '../../../controller/toggle/toggle_state.dart';
import '../../../core/reusable_widgets/reusable_text_form_field.dart';

class TextFieldSection extends StatelessWidget {
  TextFieldSection({
    super.key,
    required this.length,
    required this.text,
    required this.controller,
    this.isSignInScreen = true,
    this.suffixIcon,
  });
  final int length;
  final List<String> text;
  final List<TextEditingController> controller;
  final bool isSignInScreen;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, ToggleState>(
      builder: (BuildContext context, state) {
        return Column(
          children: List.generate(length, (e) {
            return Column(
              children: [
                SizedBox(height: 1.h),
                ReusableTextFormField(
                  textStyle: TextStyle(color: Colors.black),
                  keyboardType: isSignInScreen == false && e == 2
                      ? TextInputType.phone
                      : TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "* required";
                    }
                    if (e == 4) {
                      if (controller[3].text != controller[4].text) {
                        return "password doesn't match";
                      }
                    }
                    if (e == 2) {
                      if (val.length != 11) {
                        return "length is 11";
                      }
                    }
                    return null;
                  },
                  suffixIcon: isSignInScreen && e == 1
                      ? IconButton(
                          onPressed: () {
                            context
                                .read<ToggleCubit>()
                                .togglePasswordVisibility();
                          },
                          icon: !state.togglePasswordVisibility
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black,
                                )
                              : Icon(Icons.remove_red_eye, color: Colors.black),
                        )
                      : !isSignInScreen && e == 3 || e == 4
                      ? IconButton(
                          onPressed: () {
                            context
                                .read<ToggleCubit>()
                                .togglePasswordVisibility();
                          },
                          icon: state.togglePasswordVisibility
                              ? Icon(Icons.remove_red_eye, color: Colors.black)
                              : Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black,
                                ),
                        )
                      : SizedBox(),
                  filled: true,
                  fillColor: Color(0xffE2F8FE),
                  controller: controller[e],
                  obscureText: (e == 3 || e == 4 && isSignInScreen == false)
                      ? state.togglePasswordVisibility
                      : (e == 1 && isSignInScreen == true)
                      ? state.togglePasswordVisibility
                      : false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  hintText: text[e],
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
