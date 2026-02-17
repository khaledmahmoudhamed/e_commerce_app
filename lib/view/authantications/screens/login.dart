import 'package:e_commerce_app/cubit/auth/auth_cubit.dart';
import 'package:e_commerce_app/cubit/auth/auth_state.dart';
import 'package:e_commerce_app/initial_screen.dart';
import 'package:e_commerce_app/view/authantications/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/reusable_widgets/app_messages.dart';
import '../../../core/reusable_widgets/reusable_button.dart';
import '../widgets/divider_section.dart';
import '../widgets/facebook_and_google_auth.dart';
import '../widgets/have_account_section.dart';
import '../widgets/header_section.dart';
import '../widgets/text_field_section.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is SuccessLoginState) {
              AppMessages.show(context, message: "Welcome Back.");
              context.read<AuthCubit>().getUserData();
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => InitialScreen()),
                );
              });
            } else if (state is FailedLoginState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Center(child: Text(state.error))),
              );
            }
          },
          builder: (BuildContext context, AuthState state) {
            return Padding(
              padding: EdgeInsets.only(top: 7.h, left: 5.w, right: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(
                      asset: "assets/log_in.svg",
                      authText: "Log In",
                      subText:
                          "Register now to start shopping your favorite beauty and skincare essentials",
                    ),
                    SizedBox(height: 4.h),
                    FacebookAndGoogleAuth(),
                    SizedBox(height: 2.h),
                    DividerSection(),
                    SizedBox(height: 1.5.h),
                    TextFieldSection(
                      length: 2,
                      text: ["User Name", "Password"],
                      controller: [userNameController, passwordController],
                      isSignInScreen: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "forget password?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    ReusableButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            userName: userNameController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      alignment: Alignment.center,
                      width: double.infinity,
                      containerColor: Color(0xff425BAF),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    HaveAccountSection(
                      text: 'Sign Up',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
