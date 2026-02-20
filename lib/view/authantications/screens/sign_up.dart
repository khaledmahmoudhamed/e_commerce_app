import 'package:e_commerce_app/core/reusable_widgets/app_messages.dart';
import 'package:e_commerce_app/core/reusable_widgets/reusable_button.dart';
import 'package:e_commerce_app/view/authantications/screens/login.dart';
import 'package:e_commerce_app/view/authantications/widgets/header_section.dart';
import 'package:e_commerce_app/view/authantications/widgets/privacy_policy_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/auth/auth_cubit.dart';
import '../../../controller/auth/auth_state.dart';
import '../widgets/divider_section.dart';
import '../widgets/facebook_and_google_auth.dart';
import '../widgets/have_account_section.dart';
import '../widgets/text_field_section.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SuccessRegisterState) {
              AppMessages.show(
                context,
                message:
                    "Welcome, ${state.model.userName}! Your account is ready.",
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              });
            } else if (state is FailedRegisterState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Center(child: Text(state.message))),
              );
            }
          },
          builder: (BuildContext context, state) {
            return Padding(
              padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(
                      asset: "assets/sign_up.svg",
                      authText: "Sign Up",
                      subText:
                          "Register now to start shopping your favorite beauty and skincare essentials",
                    ),
                    SizedBox(height: 2.h),
                    FacebookAndGoogleAuth(),
                    SizedBox(height: 0.5.h),
                    DividerSection(),
                    SizedBox(height: 0.5.h),
                    TextFieldSection(
                      text: [
                        "Name",
                        "Email",
                        "Phone",
                        "Password",
                        "Confirm Password",
                      ],
                      length: 5,
                      controller: [
                        nameController,
                        emailController,
                        phoneController,
                        passwordController,
                        confirmPasswordController,
                      ],
                      isSignInScreen: false,
                    ),
                    PrivacyPolicySection(),
                    state is LoadingRegisterState
                        ? Center(child: CircularProgressIndicator())
                        : ReusableButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
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
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    SizedBox(height: 1.h),
                    HaveAccountSection(
                      text: 'Sign In',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                    SizedBox(height: 1.h),
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
