import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/core/api/api_interceptor.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/initial_screen.dart';
import 'package:e_commerce_app/view/authantications/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Future<void> _checkAuth() async {
    await Future.delayed(Duration(seconds: 2));
    final token = CacheHelper().getData(key: ApiKey.accessToken);
    if (token != null) {
      NavigationService.navigateToReplacement(InitialScreen());
    } else {
      NavigationService.navigateToReplacement(Login());
    }
  }

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80.sp, color: Colors.white),
            SizedBox(height: 2.h),
            Text(
              "E-Commerce App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
